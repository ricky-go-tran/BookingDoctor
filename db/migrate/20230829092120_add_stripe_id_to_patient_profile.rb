class AddStripeIdToPatientProfile < ActiveRecord::Migration[7.0]
  def up
    add_column :patient_profiles, :stripe_id, :string
  end

  def down
    remove_column :patient_profiles, :stripe_id
  end
end
