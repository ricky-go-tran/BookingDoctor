class AddNewColumnToProfile < ActiveRecord::Migration[7.0]
  def up
    add_reference :profiles, :user, null: false, foreign_key: true
  end

  def down
    remove_reference :profile, :user,  null: false, foreign_key: true
  end
end
