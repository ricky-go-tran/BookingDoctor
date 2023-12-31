# frozen_string_literal: true

class PrescriptionItem < ApplicationRecord
  resourcify

  belongs_to :medical_record
  belongs_to :medical_resource

  validates :medical_resource_id, :price, :amount, presence: true
  validates :amount, :price, numericality: { greater_than: 0, message: 'Greater than 0' }
end
