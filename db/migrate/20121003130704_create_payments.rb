class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :description
      t.boolean :status
      t.date :due_date
      t.date :payment_date

      t.timestamps
    end
  end
end
