# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :content, null: false
      t.string :type, null: false, default: 'system_prolem'
      t.string :status, null: false, default: 'unprocess'

      t.timestamps
    end
  end
end
