# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :clinic_profile
  belongs_to :patient_profile
  resourcify

  enum rate: %i[0 1 2 3 4 5]
end
