# frozen_string_literal: true

class Patient::ProfilesController < Patient::BaseController
  skip_before_action :check_first_login, only: %i[new create]
  before_action :check_normal_login, only: %i[new create]

  def index; end

  def detail; end

  def change
    @profile = Profile.find(current_user.profile.id)
  end

  def update
    @profile = Profile.find(current_user.profile.id)
    if @profile.update(profile_params)
      flash[:success_notice] = 'Success! Save profile is finish'
      redirect_to patient_profiles_path
    else
      flash[:error_notice] = 'Error! Profile can\'t save'
      render :change, status: 422
    end
  end

  def destroy; end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      flash[:success_notice] = 'Success! Create profile is finish'
      redirect_to patient_profiles_path
    else
      flash[:error_notice] = 'Error! Profile can\'t create'
      render :new, status: 422
    end
  end

  def new
    @profile = Profile.new
    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:fullname, :birthday, :address)
  end

  def check_normal_login
    return if is_first_login?

    redirect_to patient_profiles_path
  end
end
