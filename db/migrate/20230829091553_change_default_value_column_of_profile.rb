class ChangeDefaultValueColumnOfProfile < ActiveRecord::Migration[7.0]
  def change
    change_column_default :profiles, :status, 'valid'
  end
end
