class AddProfessionalIdToSalon < ActiveRecord::Migration
  def change
    add_column :salons, :professional_id, :integer
  end
end
