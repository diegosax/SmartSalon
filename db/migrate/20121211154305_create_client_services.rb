class CreateClientServices < ActiveRecord::Migration
  def change
    create_table :client_services do |t|
      t.integer :duration
      t.integer :client_id
      t.integer :service_id
      t.timestamps
    end
  end
end
