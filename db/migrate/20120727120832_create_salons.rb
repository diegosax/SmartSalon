class CreateSalons < ActiveRecord::Migration
  def change
    create_table :salons do |t|
      t.string :name
      t.string :username
      t.string :fone
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :complement
      t.string :email
      t.string :logo

      t.timestamps
    end
  end
end
