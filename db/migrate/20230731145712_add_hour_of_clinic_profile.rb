class AddHourOfClinicProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :clinic_profiles, :start_hour, :time, null: false, default: Time.now
    add_column :clinic_profiles, :end_hour, :time,null: false, default: Time.now
  end
end
