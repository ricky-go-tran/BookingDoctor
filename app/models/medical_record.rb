# frozen_string_literal: true

class MedicalRecord < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :clinic_profile
  has_one :examination_resul
  has_many :prescription_items
  has_many :medical_resources, through: :prescription_items
  has_many :service_items
  has_many :services, through: :service_items
  resourcify

  validate :check_overlapping, on: :create

  accepts_nested_attributes_for :examination_resul, :prescription_items, :service_items

  enum status: { appointment: 'appointment', progress: 'progress', finish: 'finish', cancle: 'cancle' }
  validates :status, inclusion: { in: %w[appointment progress finish cancle] }

  scope :current_month, ->(id) {
    where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month, clinic_profile_id: id)
  }
  scope :current_month_cancel, ->(id) {
    where(status: 'cancle', created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month, clinic_profile_id: id)
  }
  scope :current_month_finish, ->(id) {
    where(status: 'finish', created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month, clinic_profile_id: id)
  }
  scope :prev_month, ->(id) {
    where(created_at: Time.zone.now.prev_month.beginning_of_month..Time.zone.now.prev_month.end_of_month, clinic_profile_id: id)
  }
  scope :prev_month_cancel, ->(id) {
    where(status: 'cancle', created_at: Time.zone.now.prev_month.beginning_of_month..Time.zone.now.prev_month.end_of_month, clinic_profile_id: id)
  }
  scope :prev_month_finish, ->(id) {
    where(status: 'finish', created_at: Time.zone.now.prev_month.beginning_of_month..Time.zone.now.prev_month.end_of_month, clinic_profile_id: id)
  }

  scope :current_appointment_by_clinic, ->(id) {
    where(status: 'appointment', clinic_profile_id: id)
  }

  scope :get_current_progess_in_clinic, ->(clinic_id) {
    find_by(status: 'progress', clinic_profile_id: clinic_id)
  }

  private

  def check_overlapping
    overlaps = if id.nil?
                 MedicalRecord.where('status != \'cancle\' AND (start_time, end_time) OVERLAPS (?, ?)', start_time, end_time)
               else
                 MedicalRecord.where(' id != ? AND status != \'cancle\' AND (start_time, end_time) OVERLAPS (?, ?)', id, start_time, end_time)
               end
    if overlaps.present?
      errors.add(:base, 'Booking overlaps with existing records')
    end
  end
end
