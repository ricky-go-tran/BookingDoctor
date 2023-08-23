# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def date_format(datetime_obj)
    datetime_obj.strftime('%H:%M %d-%m-%Y')
  end

  def active_navbar(controller, actions)
    controller == (params[:controller]) && actions.include?(params[:action]) ? 'active' : nil
  end

  def active_icon_navbar(controller, actions)
    controller == (params[:controller]) && actions.include?(params[:action]) ? 'active_icon' : nil
  end
end
