class ChartItemService < ApplicationService
  attr_reader :resource_id, :title, :color, :start_time, :end_time

  def initialize(resource_id, title, color, start_time, end_time)
    @resource_id = resource_id
    @title = title
    @color = color
    @start_time = start_time
    @end_time = end_time
  end

  def call
    booking = {}
    booking[:start] = @start_time
    booking[:end] = @end_time
    booking[:resourceId] = @resource_id
    booking[:title] = @title
    booking[:color] = @color
    booking
  end
end
