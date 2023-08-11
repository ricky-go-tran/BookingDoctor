class FinpaysChannel < ApplicationCable::Channel
  def subscribed
    stream_from "finpays:#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end