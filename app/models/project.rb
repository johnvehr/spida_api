class Project < ApplicationRecord
  has_many_attached :files
  belongs_to :account
  has_many :tasks

  has_many :project_team_members
  has_many :users, through: :project_team_members

  has_many :project_events
  #accepts_nested_attributes_for :project_team_member


  def find_project_manager
    self.project_manager ? User.find(self.project_manager) : 'No'
  end

  def find_project_manager_as_user
    team_members = self.includes(:project_team_members)
    project_manager_id = self.project_manager
    project_manager = team_members.where(id: project_manager_id)
    return project_manager
  end
end
