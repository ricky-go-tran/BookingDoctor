# frozen_string_literal: true

class Service < ApplicationRecord
  has_many :consumptions
  has_many :medical_resources, through: :consumptions
  has_many :service_items
  has_many :medical_records, through: :service_items
  belongs_to :clinic_profile
  resourcify
  validates :name, :description, :price, :execution_time, presence: true
  validates :name, length: { in: 5..200, message: 'Lengths from 5 to 200 ' }
  validates :description, length: { in: 5..15000, message: 'Lengths from 5 to 15000 ' }
  validates :execution_time, :price, numericality: { greater_than: 0, message: 'Greater than 0' }
  has_one_attached :service_wallpaper
  validates :service_wallpaper, attached: true, size: { less_than: 10.megabytes, message: 'Please choose a photo smaller than 10mb' }, content_type: { in: %w[image/png image/jpeg], message: "It isn't a image" }

  scope :search, ->(query) {
    where('UPPER("name") LIKE UPPER(?)', "%#{query}%")
  }

  scope :top_5_in_month, ->(id) {
    joins(:service_items)
      .where('services.clinic_profile_id = ? AND service_items.created_at  BETWEEN ? AND ?', id, Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
      .group('services.id')
      .order('COUNT(service_items.id) DESC')
      .limit(5)
      .count
  }

  scope :get_price_by_id, ->(id) {
    find_by(id:).price
  }
  scope :get_execution_time_by_id, ->(id) {
    find_by(id:).execution_time
  }
end
