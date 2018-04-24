class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender, null: false
      t.string :phone, null: false
      t.string :country, null: false
      t.date :birthdate, null: false
    end
  end
end
