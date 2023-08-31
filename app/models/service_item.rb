# frozen_string_literal: true

class ServiceItem < ApplicationRecord
  resourcify

  belongs_to :medical_record
  belongs_to :service

  validates :price, presence: true
end
