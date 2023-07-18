class PrescriptionItem < ApplicationRecord
  belongs_to :medical_record
  belongs_to :medical_resource
end
