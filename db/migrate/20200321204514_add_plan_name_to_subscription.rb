class AddPlanNameToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :plan_name, :integer
  end
end
