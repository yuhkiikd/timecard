class AddIndexToTimeCards < ActiveRecord::Migration[5.2]
  def change
    add_index :time_cards, [:user_id, :year, :month, :day], unique: true
  end
end