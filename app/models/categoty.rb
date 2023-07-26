# frozen_string_literal: true

class Categoty < ApplicationRecord
  has_many :clinic_profiles
  resourcify
end
