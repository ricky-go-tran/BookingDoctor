# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  before_action :get_user, only: %i[show detail_request]
  before_action :get_profile, only: %i[accepted canceled]

  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search])
    elsif params[:type]
      @users = @users.select do |user|
        user.has_role?(params[:type].downcase)
      end
    else
      @users
    end
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_users.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def show
    @profile = @user.profile
    if @user.has_role?(:clinic) && @profile.status != 'cancle'
      @category = Category.get_name_by_user(@user)
      @start_day = ClinicProfile.get_start_day_by_user(@user)
      @end_day = ClinicProfile.get_end_day_by_user(@user)
    end
  end

  def request_verify
    @users = User.where(id: Profile.select(:user_id).where(status: 'invalid'))
    @users = @users.reject { |user| user&.profile&.clinic_profile.nil? }
  end

  def detail_request
    @profile = @user.profile
    @category = Category.get_name_by_user(@user)
    @start_day = ClinicProfile.get_start_day_by_user(@user)
    @end_day = ClinicProfile.get_end_day_by_user(@user)
  end

  def accepted
    @profile.status = 'valid'
    @profile.save
    redirect_to request_verify_admin_users_path
  end

  def canceled
    @profile.status = 'cancle'
    @profile.save
    redirect_to request_verify_admin_users_path
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def get_profile
    @profile = Profile.find(params[:id])
  end
end
