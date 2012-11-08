class AddMoipCodeToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :moip_code, :string
  end
end
