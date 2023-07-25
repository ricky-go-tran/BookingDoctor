class Patient::ProfilesController < Patient::BaseController
  skip_before_action :check_first_login, only: %i[new create]
  before_action :check_normal_login, only: %i[new create]

  def index
  end

  def show
  end

  def update

  end

  def edit
  end

  def destroy
  end
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to patient_profiles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @profile = Profile.new
    respond_to do |format|
      format.html { render layout: "application" }
    end
  end

  protected
  def profile_params
    params.require(:profile).permit(:fullname, :birthday, :address)
  end

  def check_normal_login
    if !is_first_login?
      redirect_to  patient_profiles_path
    end
  end


end
