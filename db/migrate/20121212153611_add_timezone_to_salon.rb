class AddTimezoneToSalon < ActiveRecord::Migration
  def change
    add_column :salons, :timezone, :string
  end
end
