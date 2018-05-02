class CreateReservations < ActiveRecord::Migration[5.1]
    def change
      create_table :reservations do |t|
        t.timestamps null: false
        t.date :check_in
        t.date :check_out
        t.references :user, foreign_key: true
        t.references :listing, foreign_key: true
      end
    end
  end