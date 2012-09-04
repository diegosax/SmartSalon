class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :salon_id
      t.integer :client_id

      t.timestamps
    end
  end
end
