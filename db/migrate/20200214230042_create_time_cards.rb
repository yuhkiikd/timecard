class CreateTimeCards < ActiveRecord::Migration[5.2]
  def change
    create_table :time_cards do |t|
      t.time :worked_in_at
      t.time :worked_out_at
      t.time :breaked_in_at
      t.time :breaked_out_at
      t.references :user, foreing_key: true

      t.timestamps
    end
  end
end