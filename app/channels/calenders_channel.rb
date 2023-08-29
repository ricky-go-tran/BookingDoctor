class CalendersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'calendars_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
