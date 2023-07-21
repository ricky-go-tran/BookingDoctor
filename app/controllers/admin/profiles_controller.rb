class Admin::ProfilesController < Admin::BaseController

  def index

  end

  def update
  end

  def change
    @profile = Profile.find(current_user.profile.id)
  end

  def create
  end

  def new
  end
  def show

  end
end
