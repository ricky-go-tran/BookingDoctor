# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def up
    create_table :profiles do |t|
      t.string :fullname
      t.date :birthday
      t.text :address
      t.boolean :status, default: true

      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
