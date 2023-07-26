# frozen_string_literal: true

class PatientProfile < ApplicationRecord
  belongs_to :profile
  has_many :medical_records
  has_many :votes
  has_many :clinic_profiles, through: :votes
  resourcify

  enum blood_group: { A_Positive: 'A+', A_Negative: 'A-', B_Positive: 'B+', B_Negative: 'B-',
                      O_Positive: 'O+', O_Negative: 'O-', AB_Negative: 'AB-', AB_Positive: 'AB+' }
end
