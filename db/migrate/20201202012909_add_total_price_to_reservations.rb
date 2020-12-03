class AddTotalPriceToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :total_price, :decimal
  end
end
