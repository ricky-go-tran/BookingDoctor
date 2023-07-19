class Patient::ProfilesController < ApplicationController
  skip_before_action :check_first_login, only: %i[new create]
  def index
  end

  def show
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def create
  end

  def new
  end

  #protected


end
