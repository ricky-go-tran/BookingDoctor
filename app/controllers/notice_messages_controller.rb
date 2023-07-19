class NoticeMessagesController < ApplicationController
  skip_before_action :authenticate_user!

  layout "error_layout"

  def unconfirmation
  end
end
