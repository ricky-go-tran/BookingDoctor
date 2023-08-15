# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  layout 'admin_layout'
  before_action :require_admin

  private

  def require_admin
    return if current_user.has_role? :admin

    redirect_to root_path
  end
end
