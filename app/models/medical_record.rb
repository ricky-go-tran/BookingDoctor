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

  validate :check_overlapping

  accepts_nested_attributes_for :examination_resul, :prescription_items, :service_items

  enum status: { appointment: 'appointment', progress: 'progress', finish: 'finish', cancle: 'cancle' }
  validates :status, inclusion: { in: %w[appointment progress finish cancle] }

  scope :current_month, -> {
    where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }
  scope :current_month_cancel, -> {
    where(status: 'cancel', created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }
  scope :current_month_finish, -> {
    where(status: 'finish', created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }
  scope :prev_month, -> {
    where(created_at: Time.zone.now.prev_month.beginning_of_month..Time.zone.now.prev_month.end_of_month)
  }
  scope :prev_month_cancel, -> {
    where(status: 'cancel', created_at: Time.zone.now.prev_month.beginning_of_month..Time.zone.now.prev_month.end_of_month)
  }
  scope :prev_month_finish, -> {
    where(status: 'finish', created_at: Time.zone.now.prev_month.beginning_of_month..Time.zone.now.prev_month.end_of_month)
  }

  scope :current_week_by_clinic, ->(id) {
    where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week, clinic_profile_id: id)
  }

  scope :current_week_by_clinic, ->(id) {
    where(status: 'appointment', clinic_profile_id: id)
  }

  private

  def check_overlapping
    overlaps = MedicalRecord.where('(start_time, end_time) OVERLAPS (?, ?)', start_time, end_time)
    if overlaps.present?
      errors.add(:base, 'Booking overlaps with existing records')
    end
  end
end
