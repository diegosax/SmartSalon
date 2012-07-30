class AddNeighborhoodToSalon < ActiveRecord::Migration
  def change
    add_column :salons, :neighborhood, :string
  end
end
