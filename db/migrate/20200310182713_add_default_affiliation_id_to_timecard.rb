class AddDefaultAffiliationIdToTimecard < ActiveRecord::Migration[5.2]
  def change
     change_column :time_cards, :affiliation_id, :integer, null: false, :default => 1
  end
end