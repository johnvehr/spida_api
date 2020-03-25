class AddAncestryToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :ancestry, :string
    add_index :tasks, :ancestry
  end
end
