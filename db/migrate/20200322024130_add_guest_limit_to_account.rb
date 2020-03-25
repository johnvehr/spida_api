class AddGuestLimitToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :guest_limit, :boolean
  end
end
