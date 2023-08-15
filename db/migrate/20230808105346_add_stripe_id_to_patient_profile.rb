class AddStripeIdToPatientProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_profiles, :stripe_id, :string

  end
end
