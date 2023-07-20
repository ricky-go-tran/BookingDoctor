class HomepagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_first_login
  layout "homepage_layout"
  def index
  end

  def clinics
  end

  def services
  end

  def doctors
  end

  def blogs
  end

  def supports
  end
end
