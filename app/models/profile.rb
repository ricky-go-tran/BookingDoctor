# frozen_string_literal: true

class Profile < ApplicationRecord
  has_one :clinic_profile
  has_one :patient_profile
  validates :fullname, presence: true
  resourcify
end
