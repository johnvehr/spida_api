class AddPendingToInvitation < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :pending, :boolean
  end
end
