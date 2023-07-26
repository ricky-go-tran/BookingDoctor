# frozen_string_literal: true

class PrescriptionItem < ApplicationRecord
  belongs_to :medical_record
  belongs_to :medical_resource
  resourcify
end
