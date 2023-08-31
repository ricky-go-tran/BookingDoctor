class AddStripePaymentIdToMedicalRecord < ActiveRecord::Migration[7.0]
  def up
    add_column :medical_records, :stripe_payment_id, :string, default: "nil"
  end

  def down
     remove_column :medical_records, :stripe_payment_id
  end
end
