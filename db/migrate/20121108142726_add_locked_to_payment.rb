class AddLockedToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :locked, :boolean, :default => false
  end
end
