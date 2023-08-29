# frozen_string_literal: true

class CreateConsumptions < ActiveRecord::Migration[7.0]
  def up
    create_table :consumptions do |t|
      t.references :service, null: false, foreign_key: true
      t.references :medical_resource, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :consumptions
  end
end
