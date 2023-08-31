# frozen_string_literal: true

class Report < ApplicationRecord
  resourcify

  belongs_to :user

  scope :search, ->(_query) { where('UPPER(title) LIKE UPPER(?)', "%#{params[:search]}%") }
end
