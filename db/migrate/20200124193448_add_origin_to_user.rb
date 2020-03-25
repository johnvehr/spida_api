class AddOriginToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :origin, :integer
  end
end
