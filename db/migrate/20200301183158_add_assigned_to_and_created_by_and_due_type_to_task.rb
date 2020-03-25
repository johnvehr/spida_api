class AddAssignedToAndCreatedByAndDueTypeToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :assigned_to, :string
    add_column :tasks, :created_by, :string
    add_column :tasks, :due_type, :boolean
  end
end
