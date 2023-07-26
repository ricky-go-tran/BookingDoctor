# frozen_string_literal: true

class ServiceItem < ApplicationRecord
  belongs_to :medical_record
  belongs_to :service
  resourcify
end
