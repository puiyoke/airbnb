class AddImgsToListings < ActiveRecord::Migration[5.1]
    def change
      add_column :listings, :imgs, :string
    end
  end