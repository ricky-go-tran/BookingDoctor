class MedicalRecord < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :clinic_profile
  has_one :examination_resuls
  has_many :prescription_items
  has_many :medical_resources, through: :prescription_items
  has_many :service_items
  has_many :services, through: :service_items
  resourcify


end
