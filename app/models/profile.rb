class Profile < ApplicationRecord
  has_one :clinic_profile
  has_one :patient_profile
  resourcify
end
