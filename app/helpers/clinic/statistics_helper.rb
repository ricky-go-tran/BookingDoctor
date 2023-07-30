module Clinic::StatisticsHelper
  def growth_calc(prev, current)
    if prev != 0
      ((current - prev) / prev) * 100
    else
      0
    end
  end

  def total(medical_records)
    medical_records.sum do |medical_record|
      total_service = medical_record.service_items.sum do |service_item|
        service_item.price * service_item.amount
      end
      total_prescription = medical_record.prescription_items.sum do |prescription_item|
        prescription_item.price * prescription_item.amount
      end
      total_service + total_prescription
    end
  end
end
