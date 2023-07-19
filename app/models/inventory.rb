class Inventory < ApplicationRecord
  belongs_to :medical_resource
  belongs_to :clinic_profile
  resourcify
end
