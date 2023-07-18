class CreateServiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :service_items do |t|
      t.references :medical_record, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
