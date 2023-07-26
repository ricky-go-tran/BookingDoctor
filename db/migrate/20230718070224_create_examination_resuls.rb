# frozen_string_literal: true

class CreateExaminationResuls < ActiveRecord::Migration[7.0]
  def change
    create_table :examination_resuls do |t|
      t.references :medical_record, null: false, foreign_key: true
      t.float :body_temp
      t.integer :heart_rate
      t.integer :blood_pressure
      t.text :desciption
      t.text :conslusion

      t.timestamps
    end
  end
end
