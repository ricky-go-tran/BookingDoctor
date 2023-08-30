# frozen_string_literal: true

class Patient::ProfilesController < Patient::BaseController
  skip_before_action :check_first_login, only: %i[new create]
  before_action :check_normal_login, only: %i[new create]
  before_action :get_profile, only: %i[change update]

  def index; end

  def detail; end

  def change; end

  def update
    @profile = Profile.find(current_user.profile.id)
    if @profile.update(profile_params)
      redirect_to patient_profiles_path
    else
      render :change, status: 422, layout: false
    end
  end

  def destroy; end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      flash[:success_notice] = I18n.t('profile.create_success')
      redirect_to patient_profiles_path
    else
      flash[:error_notice] = I18n.t('profile.create_error')
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

  def get_profile
    @profile = Profile.find(current_user.profile.id)
  end
end
