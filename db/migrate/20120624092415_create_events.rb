class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :client_id
      t.integer :professional_id
      t.string :status
      t.datetime :start_at
      t.integer :duration
      t.boolean :changeable

      t.timestamps
    end
  end
end
