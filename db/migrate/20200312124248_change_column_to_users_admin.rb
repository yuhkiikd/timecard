class ChangeColumnToUsersAdmin < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :admin, :boolean, null: false, default: false
  end

  def down
    change_column :users, :admin, :boolean, null: false, default: true
  end
end
