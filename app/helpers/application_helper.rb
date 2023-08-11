# frozen_string_literal: true

module ApplicationHelper
  def date_format(datetime_obj)
    datetime_obj.strftime('%H:%M %d-%m-%Y')
  end
end
