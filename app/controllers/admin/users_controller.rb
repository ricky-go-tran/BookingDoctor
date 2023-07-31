# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    if params[:query]
      @users = User.search(params[:query])
    elsif params[:type]
      @users = @users.select do |user|
        user.has_role? params[:type]
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
    @user = User.find(params[:id])
  end

  def request_verify
    @users = User.where(id: Profile.select(:user_id).where(status: 'invalid'))
    @users = @users.reject { |user| user&.profile&.clinic_profile.nil? }
  end

  def detail_request
    @user = User.find(params[:id])
    @profile = @user.profile
    @category = Category.get_name_by_user(@user)
    @start_day = ClinicProfile.get_start_day_by_user(@user)
    @end_day = ClinicProfile.get_end_day_by_user(@user)
  end

  def accepted
    @profile = Profile.find(params[:id])
    @profile.status = 'valid'
    @profile.save
    redirect_to request_verify_admin_users_path
  end

  def canceled
    @profile = Profile.find(params[:id])
    @profile.status = 'cancle'
    @profile.save
    redirect_to request_verify_admin_users_path
  end
end
