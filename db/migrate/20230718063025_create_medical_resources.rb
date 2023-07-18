class CreateMedicalResources < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_resources do |t|
      t.string :name, null: false
      t.string :brand, null: false
      t.string :unit, null: false
      t.text :description, null: false
      t.string :type, null: false, default: "medicine"

      t.timestamps
    end
  end
end
