class PrescriptionItemJsonCreator < ApplicationService
  attr_reader :prescription_items

  def initialize(prescription_items)
    @prescription_items = prescription_items
  end

  def call
    list = []
    @prescription_items.each do |item|
      line_item = {}
      line_item[:quantity] = item.amount
      line_item[:price_data] = {}
      line_item[:price_data][:currency] = 'usd'
      line_item[:price_data][:unit_amount] = item.price.to_i * 100
      line_item[:price_data][:product_data] = {}
      line_item[:price_data][:product_data][:name] = item.medical_resource.name
      line_item[:price_data][:product_data][:description] = item.medical_resource.description
      list.push(line_item)
    end
    list
  end
end
