class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.datetime :reservation_date
      t.integer :number_of_nights
      t.integer :number_of_guest
      t.boolean :approved, default: false
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
