class CreatePrescriptionItems < ActiveRecord::Migration[7.0]
  def up
    create_table :prescription_items do |t|
      t.references :medical_record, null: false, foreign_key: true
      t.references :medical_resource, null: false, foreign_key: true
      t.integer :amount
      t.float :price
      t.timestamps
    end
  end

  def down
    drop_table :prescription_items
  end
end
