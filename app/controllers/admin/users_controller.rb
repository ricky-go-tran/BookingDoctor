class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    if params[:query]
      @users = User.where(id: Profile.select(:user_id).where('fullname LIKE ?', "%#{params[:query]}%")).or(User.where('email LIKE ?', "%#{params[:query]}%"))
    elsif params[:type]
      @users = @users.select do |user|
        user.has_role? params[:type]
      end
    else
      @users
    end
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="all_users.xlsx"'
        render xlsx: "index", layout: false
      }
    end

  end

  def show
    @user = User.find(params[:id])
  end
end
