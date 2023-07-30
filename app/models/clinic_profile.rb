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

  scope :current_month, -> {
    where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }

  enum hour: %i[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]
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
