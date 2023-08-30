class Clinic::PdfsController < ApplicationController
  def prescription
    @medical_record = MedicalRecord.find(params[:id])
    @patient = @medical_record.patient_profile
    @profile = @patient.profile
    @prescription = @medical_record.prescription_items
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Prescription_#{Time.now}", template: 'clinic/pdfs/prescription', formats: :slim, layout: 'pdf', encoding: 'UTF-8'
      end
    end
  end

  def invoice
    @medical_record = MedicalRecord.find(params[:id])
    @patient = @medical_record.patient_profile
    @profile = @patient.profile
    @prescription = @medical_record.prescription_items
    @services = @medical_record.service_items
    @service_amount = @services.group(:service_id).count
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice_#{Time.now}_#{@medical_record.clinic_profile.id}", template: 'clinic/pdfs/invoice', formats: :slim, layout: 'layouts/pdf', encoding: 'UTF-8'
      end
    end
  end
end
