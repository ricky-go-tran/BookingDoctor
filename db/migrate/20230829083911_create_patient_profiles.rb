class CreatePatientProfiles < ActiveRecord::Migration[7.0]
  def up
    create_table :patient_profiles do |t|
      t.references :profile, null: false, foreign_key: true
      t.float :height
      t.float :weight
      t.string :blood_group
      t.text :drug_allergy

      t.timestamps
    end
  end

  def down
    drop_table :patient_profiles
  end
end
