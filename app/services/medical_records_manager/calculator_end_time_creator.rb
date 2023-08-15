class MedicalRecordsManager::CalculatorEndTimeCreator < ApplicationService
  attr_reader :medical_record

  def initialize(medical_record)
    @medical_record = medical_record
  end

  def call
    sum = 0
    @medical_record.service_items = @medical_record.service_items.map do |item|
      item.price = Service.get_price_by_id(item[:service_id])
      sum += Service.get_execution_time_by_id(item[:service_id])
      item
    end
    @medical_record.start_time + sum.minutes
  end

  private

  def get_name_patient_by_patient_id(patient_id)
    PatientProfile.find_by(id: patient_id).profile.fullname
  end
end
