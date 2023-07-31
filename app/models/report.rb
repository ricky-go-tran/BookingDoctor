# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  resourcify
  scope :search, ->(_query) { where('UPPER(title) LIKE UPPER(?)', "%#{params[:search]}%") }
end
