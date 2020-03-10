class AddColumnAffidToTimeCard < ActiveRecord::Migration[5.2]
  def change
    add_column :time_cards, :affiliation_id, :integer, null: false
  end
end