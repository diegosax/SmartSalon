class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :type
      t.string :number
      t.integer :salon_id
      t.integer :user_id

      t.timestamps
    end
  end
end
