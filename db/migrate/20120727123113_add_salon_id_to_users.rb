class AddSalonIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salon_id, :integer
  end
end
