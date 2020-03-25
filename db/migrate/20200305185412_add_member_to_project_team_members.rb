class AddMemberToProjectTeamMembers < ActiveRecord::Migration[6.0]
  def change
    add_reference :project_team_members, :member,foreign_key: true
  end
end
