class Clinic::WorkspacesController < Clinic::BaseController
  before_action :check_exist_payment, only: %i[index]
  before_action :check_finish, only: %i[finish]
  before_action :get_medical_record, only: %i[re_finish change cash_payment]

  def index
    @medical_record = MedicalRecord.where(status: 'progress', clinic_profile_id: current_user.get_profile_clinic.id).take
    if @medical_record.present?
      @patient_profile = @medical_record&.patient_profile
      @profile = @patient_profile&.profile
      @examination_result = @medical_record.examination_resul
      unless @examination_result.present?
        @examination_result = @medical_record&.build_examination_resul
      end
    end
  end

  def re_finish
    check_payment_medical_record(@medical_record.id)
    @service_items = @medical_record.service_items
    @prescription_items = @medical_record.prescription_items
  end

  def change
    @patient_profile = @medical_record&.patient_profile
    @profile = @patient_profile&.profile
    @examination_result = @medical_record.examination_resul
    @prescriptions = @medical_record.prescription_items
  end

  def cash_payment
    check_payment_medical_record(@medical_record.id)
    @medical_record.status = 'finish'
    @medical_record.save!
    substract_inventory(@medical_record)
    flash[:success_notice] = I18n.t('medical_record.basic.payment_success')
    redirect_to finish_clinic_workspace_path
  rescue StandardError => e
    flash[:error_notice] = e.message
    redirect_to clinic_workspaces_path
  end

  def finish; end

  def re_examination
    @old_medical = MedicalRecord.find_by(id: params[:id])
    @medical_record = MedicalRecord.new
  end

  private

  def medical_record_params
    params.require(:medical_record).permit(
      :status,
      service_items_attributes: [:id, :service_id, :price, :_destroy],
      prescription_items_attributes: [:id, :medical_resource_id, :amount, :price, :_destroy],
      examination_resul_attributes: [
        :id,
        :body_temp,
        :heart_rate,
        :blood_pressure,
        :desciption,
        :conslusion,
        :_destroy
      ]
    )
  end

  def check_exist_payment
    payment = MedicalRecord.where(status: 'payment', clinic_profile_id: current_user.get_profile_clinic.id).take
    if payment.present?
      redirect_to re_finish_clinic_workspace_path(payment)
    end
  end

  def substract_inventory(medical_record)
    subtract_prescription_items(medical_record.prescription_items)
    subtract_service_items(medical_record.service_items)
  end

  def subtract_prescription_items(prescription_items)
    prescription_items.each do |item|
      subtract_prescription_item(item.medical_resource_id, item.amount)
    end
  end

  def subtract_service_items(service_items)
    service_items.each do |item|
      subtract_service_item(item.service_id)
    end
  end

  def subtract_prescription_item(medical_id, consumtion_amount)
    inventory_item = Inventory.find_by(id: medical_id)
    if inventory_item.amount >= consumtion_amount
      inventory_item.amount -= consumtion_amount
      inventory_item.save
    else
      raise StandardError, I18n.t('medical_record.basic.error_amount')
    end
  end

  def subtract_service_item(service_id)
    services = Consumption.where(service_id:)
    services.each do |item|
      subtract_prescription_item(item.medical_resource_id, item.amount)
    end
  end

  def check_payment_medical_record(id)
    if MedicalRecord.find_by(id: id).status != 'payment'
      redirect_to clinic_workspaces_path
    end
  end

  def check_finish
    @medical_record = MedicalRecord.find_by(id: params[:id])
    if @medical_record.status != 'finish'
      redirect_to clinic_workspaces_path
    end
  end

  def get_medical_record
    @medical_record = MedicalRecord.find_by(id: params[:id])
  end
end
