# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :clinic_profiles
  resourcify
  validates :name, presence: true, length: { in: 5..200, message: 'Lengths from 5 to 200 ' }
  validates :description, presence: true, length: { in: 5..15000, message: 'Lengths from 5 to 15000 ' }

  scope :current_month, -> {
    where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }
  scope :search, ->(query) { where('UPPER(name) LIKE UPPER(?)', "%#{query}%") }
  scope :get_name_by_user, ->(user) {
                             find(user.profile.clinic_profile.category_id).name
                           }
  after_create_commit -> { broadcast_prepend_to 'categories', partial: 'admin/categories/category', locals: { category: self }, target: 'categories' }
  after_update_commit -> { broadcast_replace_to 'categories', partial: 'admin/categories/category' }
  after_destroy_commit -> { broadcast_remove_to 'categories' }
end
