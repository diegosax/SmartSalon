class AddNumberToSalons < ActiveRecord::Migration
  def change
    add_column :salons, :number, :string
  end
end
