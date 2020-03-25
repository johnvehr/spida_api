module Api
  module V1
    class ProjectsController < Api::V1::ApiController
      #before_action :require_account!
      before_action :set_account

      def index
        projects_list = []
        @projects = @account.projects.includes(:users)
        @projects.find_each do |p|
          puts p.project_manager
          projects_list << {
            project: p,
            project_manager: p.find_project_manager,
            project_team_members: p.users
            }
        end
        render json: projects_list
      end

      def show
        @project = @account.projects.find(params[:id])
        render json: {
          project: @project,
          project_manager: @project.find_project_manager,
          project_team_members: @project.users,
          project_status: @project.tasks.nil? ? false : true}
      end

      def create
        @project = @account.projects.create(project_params)

      #  params[:files].each do |im|
      #    @project.files.attach(im)
      #  end

        params[:project_team].each do |pt|
          acc_member_id = @account.members.find_by(user_id: pt).id
          @project.project_team_members.create(member_id: acc_member_id)
        end

        if @account.init_account
          @account.update_attributes(init_account: false)
        end

        render json: {
          project: @project,
          project_team_members: @project.project_team_members
          }
      end

      def destroy
      end

      private

      def project_params
        params.require(:project).permit(
          :project_title,
          :project_desc,
          :account_id,
          :project_manager,
          :project_active,
          :project_status,
          files: [])
      end

      def set_account
        @account = current_account
      end

    end
  end
end
