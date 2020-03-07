class ChangeColumnToTimeCards < ActiveRecord::Migration[5.2]
  def up
    change_column_null :time_cards, :overtime, false, 0
    change_column :time_cards, :overtime, :integer, default: 0
  end

  def down
    change_column_null :time_cards, :overtime, true, nil
    change_column :time_cards, :overtime, :integer, default: nil
  end
end