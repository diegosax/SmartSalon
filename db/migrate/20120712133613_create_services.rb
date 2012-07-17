class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :duration      
      t.float :price

      t.timestamps
    end
  end
end
