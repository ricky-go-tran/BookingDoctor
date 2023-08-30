class ServicesManager::InsertCountAttributeService < ApplicationService
  attr_reader :top5service

  def initialize(top5service)
    @top5service = top5service
  end

  def call
    @top5service = @top5service.map do |key, value|
      item = Service.find_by(id: key)
      item_hash = item.attributes.symbolize_keys
      item_hash[:count] = value
      item_hash
    end
    @top5service
  end
end
