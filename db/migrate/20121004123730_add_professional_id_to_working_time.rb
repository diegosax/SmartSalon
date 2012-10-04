class AddProfessionalIdToWorkingTime < ActiveRecord::Migration
  def change
    add_column :working_times, :professional_id, :integer
  end
end
