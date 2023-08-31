class ChangeDataTypeColumnOfProfile < ActiveRecord::Migration[7.0]
  def up
    change_column :profiles, :status, :string
  end
  def down
    change_column :profile, :staus, :boolean
  end
end
