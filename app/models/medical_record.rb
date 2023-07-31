# frozen_string_literal: true

class MedicalRecord < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :clinic_profile
  has_one :examination_results
  has_many :prescription_items
  has_many :medical_resources, through: :prescription_items
  has_many :service_items
  has_many :services, through: :service_items
  resourcify

  enum status: { appointment: 'appointment', finish: 'finish', cancle: 'cancle' }
  validates :status, inclusion: { in: %i[appointment finish cancle] }

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
end
