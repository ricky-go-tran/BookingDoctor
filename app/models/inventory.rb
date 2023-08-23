# frozen_string_literal: true

class Inventory < ApplicationRecord
  belongs_to :medical_resource
  belongs_to :clinic_profile
  validates :medical_resource_id, presence: true
  validates :amount, presence: true
  validates :price, presence: true
  validates :amount, :price, numericality: { greater_than: 0, message: 'Greater than 0' }
  resourcify
  scope :top_5_in_month, -> {
    joins('INNER JOIN medical_resources ON inventories.medical_resource_id = medical_resources.id')
      .joins('INNER JOIN prescription_items ON prescription_items.medical_resource_id = inventories.medical_resource_id')
      .where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      .select("medical_resources.name,
              medical_resources.brand,
             SUM(prescription_items.amount) as total_quantity")
      .group('medical_resources.id')
      .order('total_quantity DESC')
      .limit(5)
  }
  scope :get_price_by_id, ->(medical_id, clinic_id) {
    find_by(medical_resource_id: medical_id, clinic_profile_id: clinic_id).price
  }
end
