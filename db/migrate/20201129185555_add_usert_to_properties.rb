class AddUsertToProperties < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :user, index: true
    add_foreign_key :properties, :users
  end
end
