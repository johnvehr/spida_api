class AddProjectManagerToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :project_manager, :integer
  end
end
