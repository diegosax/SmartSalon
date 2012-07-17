class AddServiceIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :service_id, :integer
  end
end
