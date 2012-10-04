class CreateWorkingTimes < ActiveRecord::Migration
  def change
    create_table :working_times do |t|
      t.integer :day
      t.time :from
      t.time :to

      t.timestamps
    end
  end
end
