class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.timestamps null: false
      t.string :name, null: false
      t.string :property_type, null: false
      t.integer :guest_number, null: false
      t.string :country, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.integer :zipcode, null: false
      t.string :address, null: false
      t.string :price, null: false
      t.string :description, null: false
      t.references :user, foreign_key: true
    end
  end
end
