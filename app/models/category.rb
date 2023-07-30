# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :clinic_profiles
  resourcify
  validates :name, presence: true
  validates :description, presence: true

  scope :current_month, -> {
    where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }
  scope :search, ->(query) { where('UPPER(name) LIKE UPPER(?)', "%#{query}%") }
  scope :get_name_by_user, ->(user) { find(user.profile.clinic_profile.category_id).name }
end
