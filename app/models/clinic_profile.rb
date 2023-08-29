# frozen_string_literal: true

class ClinicProfile < ApplicationRecord
  belongs_to :profile
  belongs_to :category
  has_many :services
  has_many :medical_records
  has_many :inventories
  has_many :medical_resources, through: :inventories
  has_many :votes
  has_many :patient_profiles, through: :votes
  resourcify

  has_one_attached :certificate
  has_one_attached :clinic_view

  validates :name, :address, :phone, :description, :start_day, :end_day, :start_hour, :end_hour, presence: true
  validates :name, length: { in: 5..200, message: 'Lengths from 5 to 200 ' }
  validates :address, length: { in: 5..200, message: 'Lengths from 5 to 200 ' }
  validates :phone, length: { is: 10, message: "Phone's length must 10" }
  validates :description, length: { in: 5..15000, message: 'Lengths from 5 to 15000 ' }
  validates :start_day, :end_day, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }
  validates :certificate, attached: true, size: { less_than: 10.megabytes, message: 'Please choose a photo smaller than 10mb' }, content_type: { in: %w[image/png image/jpeg], message: "It isn't a image" }
  validates :clinic_view, attached: true, size: { less_than: 10.megabytes, message: 'Please choose a photo smaller than 10mb' }, content_type: { in: %w[image/png image/jpeg], message: "It isn't a image" }
  validate :start_hour_must_be_before_end_hour
  validate :start_day_must_be_before_end_day
  scope :current_month, -> {
    where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  }

  scope :search, ->(query) {
    select('clinic_profiles.*').joins(:profile).where(profile: { status: 'valid' })
      .where('UPPER(clinic_profiles.name) LIKE UPPER(?)', "%#{query}%")
  }

  scope :type, ->(type) {
    select('clinic_profiles.*').joins(:profile, :category).where(profile: { status: 'valid' })
      .where('UPPER(categories.name) LIKE UPPER(?)', "%#{type}%")
  }

  def start_hour_must_be_before_end_hour
    if start_hour.present? && end_hour.present? && start_hour >= end_hour
      errors.add(:end_hour, 'Must be after start hour')
    end
  end

  def start_day_must_be_before_end_day
    if start_day.present? && end_day.present? && start_day >= end_day
      errors.add(:end_day, 'Must be after start day')
    end
  end

  scope :get_start_day_by_user, ->(user) { days.key(user.profile.clinic_profile.start_day).camelize }
  scope :get_end_day_by_user, ->(user) { days.key(user.profile.clinic_profile.end_day).camelize }

  enum day: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }
end
