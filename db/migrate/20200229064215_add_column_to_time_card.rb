class AddColumnToTimeCard < ActiveRecord::Migration[5.2]
  def change
    add_column :time_cards, :worked_time, :integer
    add_column :time_cards, :breaked_time, :integer
    add_column :time_cards, :overtime, :integer
  end
end