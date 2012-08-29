class AddLocationFieldsToSalon < ActiveRecord::Migration
  def change
    add_column :salons, :latitude, :float
    add_column :salons, :longitude, :float
  end
end
