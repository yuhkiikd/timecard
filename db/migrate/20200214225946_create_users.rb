class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :mail, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: true, null: false
      t.references :affiliation, null: false

      t.timestamps
    end
  end
end