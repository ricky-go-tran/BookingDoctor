# frozen_string_literal: true

class ChangeDataTypeColumnOfProfile < ActiveRecord::Migration[7.0]
  def change
    change_column :profiles, :status, :string
  end
end
