class AddInitAccountToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :init_account, :boolean
  end
end
