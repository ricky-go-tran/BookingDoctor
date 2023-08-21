class AddStripePaymentIdToMedicalRecord < ActiveRecord::Migration[7.0]
  def change
    add_column :medical_records, :stripe_payment_id, :string, default: "nil"
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
