class CreateServiceProfessionals < ActiveRecord::Migration
  def up
  	create_table :professional_services do |t|
      t.integer :service_id
      t.integer :professional_id    
      t.integer :duration

      t.timestamps
    end
  end

  def down
  	drop_table :professional_services
  end

end
