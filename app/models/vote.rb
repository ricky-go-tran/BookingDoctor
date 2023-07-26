# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :clinic_profile
  belongs_to :patient_profile
  resourcify
end
