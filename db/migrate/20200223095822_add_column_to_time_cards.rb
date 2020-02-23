class AddColumnToTimeCards < ActiveRecord::Migration[5.2]
  def change
    add_column :time_cards, :year, :integer, limit: 2, null: false
    add_column :time_cards, :month, :integer, limit: 2, null: false
    add_column :time_cards, :day, :integer, limit: 2, null: false
  end
end