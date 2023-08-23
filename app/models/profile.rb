# frozen_string_literal: true

class Profile < ApplicationRecord
  has_one :clinic_profile
  has_one :patient_profile
  validates :fullname, presence: true, length: { in: 5..200, message: 'Lengths from 5 to 200 ' }
  validates :address, length: { in: 5..200, message: 'Lengths from 5 to 200 ' }
  resourcify
end
