class Clinic::BaseController < ApplicationController
  before_action :require_clinic

  protected
  def require_clinic
    if !current_user.has_role? :clinic
      redirect_to root_path
    end
  end

end
