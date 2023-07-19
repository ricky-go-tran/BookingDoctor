class PatientProfile < ApplicationRecord
  belongs_to :profile
  has_many :medical_records
  has_many :votes
  has_many :clinic_profiles, through: :votes
  resourcify
end
