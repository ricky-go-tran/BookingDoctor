# frozen_string_literal: true

class MedicalResource < ApplicationRecord
  has_many :consumptions
  has_many :services, through: :consumptions
  has_many :inventories
  has_many :clinic_profiles, through: :inventories
  has_many :prescription_items
  has_many :medical_records, through: :prescription_items
  resourcify
  enum medical_resource_type: { medicine: 'medicine', nutraceutical: 'nutraceutical', vaccine: 'vaccine',
                                instrucment: 'instrucment' }
  scope :search, ->(query) { where('UPPER(name) LIKE UPPER(?) OR UPPER(brand) LIKE UPPER(?)', "%#{query}%", "%#{query}%") }
  validates :name, :brand, :unit, :description, :medical_resource_type, presence: true
  validates :medical_resource_type, inclusion: { in: %w[medicine nutraceutical vaccine instrucment] }
end
