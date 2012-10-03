class AddSubscriptionIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :subscription_id, :integer
  end
end
