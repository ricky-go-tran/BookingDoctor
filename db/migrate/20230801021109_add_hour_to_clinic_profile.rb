class AddHourToClinicProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :clinic_profiles, :start_hour, :time
    add_column :clinic_profiles, :end_hour, :time
  end
end
