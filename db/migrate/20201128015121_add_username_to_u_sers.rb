class AddUsernameToUSers < ActiveRecord::Migration[6.0]
  def change
    add_column :u_sers, :username, :string
  end
end
