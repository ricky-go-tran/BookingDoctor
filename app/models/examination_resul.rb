# frozen_string_literal: true

class ExaminationResult < ApplicationRecord
  belongs_to :medical_record
  resourcify
end
