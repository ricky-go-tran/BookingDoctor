# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :clinic_profiles
  resourcify
  validates :name, presence: true
  validates :description, presence: true
end
