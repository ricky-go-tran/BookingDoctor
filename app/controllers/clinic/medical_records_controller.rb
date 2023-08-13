class Clinic::MedicalRecordsController < ApplicationController
  before_action :get_medical_record, only: %i[update]
  def create
    @medical_record = MedicalRecord.new(re_examination_params)

    @medical_record.clinic_profile_id = current_user.profile.clinic_profile.id

    @medical_record.end_time = MedicalRecordsManager::CalculatorEndTimeCreator.call(@medical_record)

    if @medical_record.save
      flash[:success_notice] = 'Success! Register appointment'
      @user_receive = User.find(@medical_record.patient_profile.profile.user_id)

      # SendmailerJob.set(wait: 10.second).perform_later(@medical_record, @user_receive.email)
      SendMailWorker.perform_async(@medical_record.to_json, @user_receive.profile.clinic_profile.to_json, @user_receive.profile.fullname, @user_receive.email)
      # MailerJob.set(wait: 10.second).perform_later(@medical_record, @user_receive.email)
      # SendMailJob.set(wait: 10.second).perform_later(@medical_record, @user_receive.email)
    else
      flash[:error_notice] = "Error! Can't appointment! Please try again"
    end
    redirect_to clinic_workspaces_path
  end

  def update
    if @medical_record.status != 'progress'
      raise StandardError, "Status is invalid!  Can't payment this appointment"
    end

    medical_record_attributes = medical_record_params.to_h

    if medical_record_attributes['prescription_items_attributes'].present?
      prescription_items = {}
      medical_record_attributes['prescription_items_attributes'].each do |key, value|
        value['price'] = Inventory.get_price_by_id(value['medical_resource_id'], current_user.get_profile_clinic.id)
        prescription_items[key] = value
      end
      medical_record_attributes['prescription_items_attributes'] = prescription_items
    end

    @medical_record.status = 'payment'

    @medical_record.update!(medical_record_attributes)
    medical_record_json = {}
    medical_record_json[:id] = @medical_record.id
    medical_record_json[:clinic_name] = current_user.get_profile_clinic.name
    medical_record_json[:start_time] = @medical_record.start_time
    medical_record_json[:end_time] = @medical_record.end_time
    ActionCable
      .server
      .broadcast("payments:#{@medical_record.patient_profile.profile.user_id}",
                 { data: medical_record_json, action: 'add' })
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

  def re_examination_params
    params.require(:medical_record).permit(:patient_profile_id, :start_time, :status, service_items_attributes: [:id, :service_id, :_destroy])
  end
end
