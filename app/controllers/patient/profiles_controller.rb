class Patient::ProfilesController < ApplicationController
  skip_before_action :check_first_login, only: %i[new create]
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
  end

  protected
  def profile_params
    params.require(:profile).permit(:fullname, :birthday, :address)
  end


end
