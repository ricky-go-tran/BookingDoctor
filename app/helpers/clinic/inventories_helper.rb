module Clinic::InventoriesHelper
  def get_medical_resource_by_id(id)
    medical = MedicalResource.find_by(id:)
    "#{medical.name} - Brand: #{medical.brand}"
  end
end
