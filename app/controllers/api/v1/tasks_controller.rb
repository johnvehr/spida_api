module Api
  module V1
    class TasksController < Api::V1::ApiController
      include Format
      before_action :set_project, only: [:create,:index]

  #before_destroy :destroy_descendants

  def index
    @tasks = @project.tasks.includes(:taggings)
    render json: {tasks: format_my_data(@project,@tasks)}
  end

  def create
    @task = @project.tasks.create(task_params)

    if params[:end_date].present?
      @project.project_events.create(
        project_event_title: @task.task_title,
        project_event_date: @task.end_date,
        )
    end
    #if task_params[:assigned_to]
    if params[:type] == 'sub'
      @task.update(parent: Task.find(params[:id]))
    end
    render json: {
      task: @task,
      tasks: format_my_data(@project,@project.tasks)
    }
  end

  def destroy
    id = params[:id]
    @task = Task.find(id)
    @task.destroy
    render json: {
      tasks: format_my_data(@project,@project.tasks)
    }
  end

#  def destroy_descendants
#    @task = Task.find(params[:id]
#    @task.children.each { |child| child.destroy }
#  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.fetch(:task).permit(
      :task_title,
      :task_desc,
      :status,
      :priority,
      :project_id,
      :assigned_to,
      :due_type,
      :start_date,
      :end_date,
      :task_tag_list
      ).merge(created_by: current_user.email)
  end

    end
  end
end
