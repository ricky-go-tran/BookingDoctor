# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.all
      if params[:query]
        @users = User.where(id: Profile.select(:user_id).where('fullname LIKE ?',
                                                               "%#{params[:query]}%")).or(User.where('email LIKE ?',
                                                                                                     "%#{params[:query]}%"))
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
      # binding.pry
      @users = @users.reject { |user| user&.profile&.clinic_profile.nil? }
    end

    def detail_request
      @user = User.find(params[:id])
      @category = Category.find(@user.profile.clinic_profile.category_id).name
      @start_day = ClinicProfile.days.key(@user.profile.clinic_profile.start_day).camelize
      @end_day = ClinicProfile.days.key(@user.profile.clinic_profile.end_day).camelize
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
end
