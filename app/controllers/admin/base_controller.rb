class Admin::BaseController < ApplicationController
  layout "admin_layout"
  before_action :require_admin

  protected
  def require_admin
    if !current_user.has_role? :admin
      redirect_to root_path
    end
  end
end
