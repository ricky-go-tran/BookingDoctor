class Clinic::ConsumptionsController < ApplicationController
  def create
    @consumption = Consumption.new(consumption_params)
    @exist_consumption = Consumption.find_by(service_id: @consumption.service_id, medical_resource_id: @consumption.medical_resource_id)
    if @exist_consumption.present?
      @exist_consumption.amount = @consumption.amount
      @exist_consumption.save
    else
      @consumption.save
    end
    redirect_to clinic_service_path(@consumption.service_id)
  end

  def destroy
    @consumption = Consumption.find(params[:service_id])
    @service_id = @consumption.service_id
    @consumption.destroy
    redirect_to clinic_service_path(@service_id)
  end

  private

  def consumption_params
    params.require(:consumption).permit(:service_id, :medical_resource_id, :amount)
  end
end
