# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :clinic_profile, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.float :price, null: false
      t.integer :execution_time

      t.timestamps
    end
  end
end
