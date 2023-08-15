class RemoveHourToClinic < ActiveRecord::Migration[7.0]
  def change
    remove_column :clinic_profiles, :start_hour
    remove_column :clinic_profiles, :end_hour
  end
end
