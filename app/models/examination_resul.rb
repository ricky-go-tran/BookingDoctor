# frozen_string_literal: true

class ExaminationResul < ApplicationRecord
  belongs_to :medical_record
  resourcify
end
