# frozen_string_literal: true

class Service < ApplicationRecord
  has_many :consumptions
  has_many :medical_resources, through: :consumptions
  has_many :service_items
  has_many :medical_records, through: :service_items
  belongs_to :clinic_profile
  resourcify
end
