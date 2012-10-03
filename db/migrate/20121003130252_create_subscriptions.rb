class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :description
      t.decimal :price
      t.boolean :status, :default => true
      t.date :initial_date
      t.date :end_date

      t.timestamps
    end
  end
end
