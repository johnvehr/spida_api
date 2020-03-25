class AddUserIndexToProjectTeamMember < ActiveRecord::Migration[6.0]
  def change
    add_index :project_team_members, :user_id
  end
end
