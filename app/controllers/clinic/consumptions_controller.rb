class Clinic::ConsumptionsController < Clinic::BaseController
  def create
    @consumption = Consumption.new(consumption_params)
    @exist_consumption = Consumption.find_by(service_id: @consumption.service_id, medical_resource_id: @consumption.medical_resource_id)
    if @exist_consumption.present?
      @exist_consumption.amount = @consumption.amount
      @exist_consumption.save
      if @exist_consumption.save
        flash[:success_notice] = I18n.t('change_success')
      else
        flash[:error_notice] = I18n.t('change_fail')
      end
    elsif @consumption.save
      flash[:success_notice] = I18n.t('change_success')
    else
      flash[:error_notice] = I18n.t('change_fail')
    end

    redirect_to clinic_service_path(@consumption.service_id)
  end

  def destroy
    @consumption = Consumption.find_by(id: params[:service_id])
    @service_id = @consumption.service_id
    if @consumption.destroy
      flash[:success_notice] = I18n.t('destroy_success')
    else
      flash[:error_notice] = I18n.t('destroy_success')
    end
    redirect_to clinic_service_path(@service_id)
  end

  private

  def consumption_params
    params.require(:consumption).permit(:service_id, :medical_resource_id, :amount)
  end
end
