class AddTrialPeriodToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :trial_period, :integer
  end
end
