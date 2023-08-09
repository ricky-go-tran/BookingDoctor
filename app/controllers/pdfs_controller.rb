class PdfsController < ApplicationController
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
        render pdf: "Invoicec_#{Time.now}_#{@medical_record.clinic_profile.id}", template: 'clinic/pdfs/invoice', formats: :slim, layout: 'layouts/pdf', encoding: 'UTF-8'
      end
    end
  end
end
