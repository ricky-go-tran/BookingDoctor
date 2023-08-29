# frozen_string_literal: true

class CreateInventories < ActiveRecord::Migration[7.0]
  def up
    create_table :inventories do |t|
      t.references :medical_resource, null: false, foreign_key: true
      t.references :clinic_profile, null: false, foreign_key: true
      t.integer :amount, null: false
      t.float :price, null: false

      t.timestamps
    end
  end

  def down
    drop_table :inventories
  end
end
