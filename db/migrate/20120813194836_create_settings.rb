class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :work_on_sundays
      t.boolean :work_on_saturdays
      t.datetime :opening_time
      t.datetime :closing_time
      t.boolean :searchable
      t.boolean :client_can_schedule

      t.timestamps
    end
  end
end
