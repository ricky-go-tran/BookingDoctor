# frozen_string_literal: true

class Service < ApplicationRecord
  has_many :consumptions
  has_many :medical_resources, through: :consumptions
  has_many :service_items
  has_many :medical_records, through: :service_items
  belongs_to :clinic_profile
  resourcify
  scope :top_5_in_month, -> {
    joins(:service_items)
      .where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      .group('services.id')
      .order('COUNT(service_items.id) DESC')
      .limit(5)
  }
end
