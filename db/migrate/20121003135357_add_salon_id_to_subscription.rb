class AddSalonIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :salon_id, :integer
  end
end
