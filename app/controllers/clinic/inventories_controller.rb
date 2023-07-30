class Clinic::InventoriesController < Clinic::BaseController
  before_action :get_inventory, only: %i[edit update show destroy]

  def index
    @inventories = Inventory.where(clinic_profile_id: current_user.profile.clinic_profile.id)
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_inventory.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def show
    @medical_resource = MedicalResource.find(@inventory.medical_resource_id)
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.clinic_profile_id = current_user.profile.clinic_profile.id
    @exist_inventory = Inventory.find_by(medical_resource_id: @inventory.medical_resource_id, clinic_profile_id: @inventory.clinic_profile_id)
    if @exist_inventory.present?
      @exist_inventory.amount += @inventory.amount
      @exist_inventory.price = @inventory.price
      if @exist_inventory.save
        redirect_to clinic_inventories_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      current_user.add_role :own, @inventory
      if @inventory.save
        redirect_to clinic_inventories_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    if @inventory.update(inventory_params)
      redirect_to clinic_inventories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory.destroy
    redirect_to clinic_inventories_path, status: :see_other
  end

  private

  def inventory_params
    params.require(:inventory).permit(:medical_resource_id, :amount, :price)
  end

  def get_inventory
    @inventory = Inventory.find(params[:id])
  end
end