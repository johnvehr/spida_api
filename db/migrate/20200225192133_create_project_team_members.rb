class CreateProjectTeamMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :project_team_members do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :user_id
      t.integer :project_access

      t.timestamps
    end
  end
end
