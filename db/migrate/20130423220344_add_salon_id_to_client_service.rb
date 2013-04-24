class AddSalonIdToClientService < ActiveRecord::Migration
  def change
    add_column :client_services, :salon_id, :integer
  end
end
