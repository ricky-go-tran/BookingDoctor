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
end
