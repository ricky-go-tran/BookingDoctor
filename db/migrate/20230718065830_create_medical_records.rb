# frozen_string_literal: true

class CreateMedicalRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_records do |t|
      t.references :patient_profile, null: false, foreign_key: true
      t.references :clinic_profile, null: false, foreign_key: true
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :status, null: false, default: 'appointment'

      t.timestamps
    end
  end
end
