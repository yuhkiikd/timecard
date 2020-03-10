class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :time_cards, :affiliation_id, :integer, null: true, default: nil
  end

  def down
    change_column :time_cards, :affiliation_id, :integer, null: false, default: 0
  end
end