# frozen_string_literal: true

class Consumption < ApplicationRecord
  resourcify

  belongs_to :service
  belongs_to :medical_resource
end
