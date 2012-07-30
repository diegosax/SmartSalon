class AddSalonIdToService < ActiveRecord::Migration
  def change
    add_column :services, :salon_id, :intnteger
  end
end
