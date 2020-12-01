class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :title
      t.string :description
      t.decimal :price_per_night

      t.timestamps
    end
  end
end
