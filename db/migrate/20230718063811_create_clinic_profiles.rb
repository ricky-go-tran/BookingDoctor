# frozen_string_literal: true

class CreateClinicProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :clinic_profiles do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.text :address, null: false
      t.string :phone, null: false
      t.text :description, null: false
      t.integer :start_hour, null: false
      t.integer :end_hour, null: false
      t.integer :start_day, null: false
      t.integer :end_day, null: false

      t.timestamps
    end
  end
end
