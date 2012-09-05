class AddRescheduleToEvent < ActiveRecord::Migration
  def change
    add_column :events, :reschedule, :boolean, :default => false
  end
end
