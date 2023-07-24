class RenameTypeToMedicalType < ActiveRecord::Migration[7.0]
  def change
    rename_column :medical_resources, :type, :medical_resource_type
  end
end
