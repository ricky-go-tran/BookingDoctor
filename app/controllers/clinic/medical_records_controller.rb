class Clinic::MedicalRecordsController < ApplicationController
  before_action :get_medical_record, only: %i[update]
  def create; end

  def update
    if @medical_record.status != 'progress'
      raise StandardError, "Status is invalid!  Can't payment this appointment"
    end

    medical_record_attributes = medical_record_params.to_h
    prescription_items = {}
    medical_record_attributes['prescription_items_attributes'].each do |key, value|
      value['price'] = Inventory.get_price_by_id(value['medical_resource_id'], current_user.get_profile_clinic.id)
      prescription_items[key] = value
    end
    medical_record_attributes['prescription_items_attributes'] = prescription_items
    @medical_record.status = 'payment'
    @medical_record.update!(medical_record_attributes)
    redirect_to clinic_workspaces_path
  rescue StandardError => e
    flash[:error_notice] = e.message
    redirect_to clinic_workspaces_path
  end

  def cashed_payment; end

  private

  def get_medical_record
    @medical_record = MedicalRecord.find(params[:id])
  end

  def medical_record_params
    params.require(:medical_record).permit(prescription_items_attributes: [:id, :medical_resource_id, :amount, :price, :_destroy], examination_resul_attributes: [:id, :body_temp, :heart_rate, :blood_pressure, :desciption, :conslusion, :_destroy])
  end
end
