class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :medical_record, null: false, foreign_key: true
      t.string :stripe_id
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
