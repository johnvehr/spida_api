class AddProjectStatusAndProjectActiveToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :project_active, :boolean
    add_column :projects, :project_status, :string
  end
end
