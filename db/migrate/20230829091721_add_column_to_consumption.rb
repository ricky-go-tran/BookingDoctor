class AddColumnToConsumption < ActiveRecord::Migration[7.0]
  def up
    add_column :consumptions, :amount, :integer
  end

  def down
    remove_column :consumptions, :amount
  end
end
