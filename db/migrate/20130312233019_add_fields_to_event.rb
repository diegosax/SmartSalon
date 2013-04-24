class AddFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :creator, :integer
    add_column :events, :service_to_client_event, :boolean, :default => false
  end
end
