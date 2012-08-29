class CreateClientsSalons < ActiveRecord::Migration
  def up
  	create_table :client_salons do |t|
      t.integer :client_id
      t.integer :salon_id          

      t.timestamps
    end
  end

  def down
  	drop_table :client_salons
  end
end
