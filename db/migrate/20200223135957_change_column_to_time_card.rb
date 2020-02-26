class ChangeColumnToTimeCard < ActiveRecord::Migration[5.2]
  def change
    remove_column :time_cards, :worked_in_at, :time
    remove_column :time_cards, :worked_out_at, :time
    remove_column :time_cards, :breaked_in_at, :time
    remove_column :time_cards, :breaked_out_at, :time
    add_column :time_cards, :worked_in_at, :datetime
    add_column :time_cards, :worked_out_at, :datetime
    add_column :time_cards, :breaked_in_at, :datetime
    add_column :time_cards, :breaked_out_at, :datetime
  end
end
