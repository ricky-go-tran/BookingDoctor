# frozen_string_literal: true

class ClinicProfile < ApplicationRecord
  belongs_to :profile
  belongs_to :category
  has_many :services
  has_many :medical_records
  has_many :inventories
  has_many :medical_resources, through: :inventories
  has_many :votes
  has_many :patient_profiles, through: :votes
  resourcify

  has_one_attached :certificate
  has_one_attached :clinic_view

  scope :current_month, -> {
    where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }

  scope :get_start_day_by_user, ->(user) { days.key(user.profile.clinic_profile.start_day).camelize }
  scope :get_end_day_by_user, ->(user) { days.key(user.profile.clinic_profile.end_day).camelize }

  enum day: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }
end
