# frozen_string_literal: true

class MedicalRecord < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :clinic_profile
  has_one :examination_resul
  has_one :payment
  has_many :prescription_items
  has_many :medical_resources, through: :prescription_items
  has_many :service_items
  has_many :services, through: :service_items
  resourcify

  validate :check_overlapping, on: :create
  validate :check_past, on: :create
  validate :check_time_in_clinic_work, on: :create
  validate :check_wday_in_clinic_work, on: :create
  validates :status, presence: true

  accepts_nested_attributes_for :examination_resul, :prescription_items, :service_items

  enum status: { appointment: 'appointment', progress: 'progress', payment: 'payment', finish: 'finish', cancle: 'cancle' }
  validates :status, inclusion: { in: %w[appointment progress payment finish cancle] }

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
    where(status: 'progress', clinic_profile_id: clinic_id).take
  }
  scope :get_by_patient_and_status, ->(id, status) { where('patient_profile_id = ? AND  UPPER(status) = UPPER(?) ', id, status) }
  private

  def check_overlapping
    overlaps = if id.nil?
                 MedicalRecord.where('clinic_profile_id = ? AND status = \'appointment\' AND (start_time, end_time) OVERLAPS (?, ?)', clinic_profile_id, start_time, end_time)
               else
                 MedicalRecord.where(' id != ? AND clinic_profile_id = ? AND status = \'appointment\' AND (start_time, end_time) OVERLAPS (?, ?)', id, clinic_profile_id, start_time, end_time)
               end
    if overlaps.present?
      errors.add(:base, 'Booking overlaps with existing records')
    end
  end

  def check_time_in_clinic_work
    clinic_profile = ClinicProfile.find_by(id: clinic_profile_id)
    if (start_time.hour < clinic_profile.start_hour.hour || (start_time.hour == clinic_profile.start_hour.hour && start_time.min <= clinic_profile.start_hour.min)) || (end_time.hour > clinic_profile.end_hour.hour || (end_time.hour == clinic_profile.end_hour.hour && end_time.min >= clinic_profile.start_hour.min))
      errors.add(:base, 'Booking is not in clinic time work')
    end
  end

  def check_past
    if start_time.past?
      errors.add(:base, 'Booking is not in past')
    end
  end

  def check_wday_in_clinic_work
    clinic_profile = ClinicProfile.find_by(id: clinic_profile_id)
    if start_time.wday < clinic_profile.start_day || start_time.wday > clinic_profile.end_day
      errors.add(:base, 'Booking is not in clinic wtime work')
    end
  end
end
