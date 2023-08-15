class AddColumnToConsumption < ActiveRecord::Migration[7.0]
  def change
    add_column :consumptions, :amount, :integer
  end
end
