class AddSalonIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :salon_id, :integer
  end
end
