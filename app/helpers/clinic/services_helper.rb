module Clinic::ServicesHelper
  def get_medical_resources_of_current_user
    MedicalResource.joins(:inventories).where("inventories.clinic_profile_id =  #{current_user.profile.clinic_profile.id}")
  end
end
