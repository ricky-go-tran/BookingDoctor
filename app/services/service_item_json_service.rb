class ServiceItemJsonService < ApplicationService
  attr_reader :service_items

  def initialize(service_items)
    @service_items = service_items
  end

  def call
    list = []
    @service_items.each do |item|
      line_item = {}
      line_item[:quantity] = 1
      line_item[:price_data] = {}
      line_item[:price_data][:currency] = 'usd'
      line_item[:price_data][:unit_amount] = item.price.to_i * 100
      line_item[:price_data][:product_data] = {}
      line_item[:price_data][:product_data][:name] = item.service.name
      line_item[:price_data][:product_data][:description] = item.service.description
      list.push(line_item)
    end
    list
  end
end
