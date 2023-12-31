class CreateVotes < ActiveRecord::Migration[7.0]
  def up
    create_table :votes do |t|
      t.references :clinic_profile, null: false, foreign_key: true
      t.references :patient_profile, null: false, foreign_key: true
      t.integer :rate, null: false
      t.text :comment
      t.timestamps
    end
  end

  def down
     drop_table :votes
  end
end
