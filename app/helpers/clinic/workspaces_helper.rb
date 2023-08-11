module Clinic::WorkspacesHelper
  def get_name_patient_by_id(id)
    PatientProfile.find_by(id:).profile.fullname
  end

  def total_price(service_items, prescription_items)
    sum = 0
    service_items.each do |item|
      sum += item.price
    end
    prescription_items.each do |item|
      sum += (item.price * item.amount)
    end
    sum
  end
end
