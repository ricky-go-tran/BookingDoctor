# frozen_string_literal: true

class ExaminationResul < ApplicationRecord
  resourcify

  belongs_to :medical_record
end
