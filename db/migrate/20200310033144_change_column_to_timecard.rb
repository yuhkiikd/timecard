class ChangeColumnToTimecard < ActiveRecord::Migration[5.2]
  def up
    change_column_null :time_cards, :worked_time, false, 0
    change_column :time_cards, :worked_time, :integer, default: 0
    change_column_null :time_cards, :breaked_time, false, 0
    change_column :time_cards, :breaked_time, :integer, default: 0
  end

  def down
    change_column_null :time_cards, :worked_time, true, nil
    change_column :time_cards, :worked_time, :integer, default: nil
    change_column_null :time_cards, :breaked_time, true, nil
    change_column :time_cards, :breaked_time, :integer, default: nil
  end
end