class AddPaymentModeToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :payment_mode, :string
  end
end
