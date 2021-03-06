class TasksController < ApplicationController
  def index
    @tasks = Task.weekly_current_task(current_user).paginate(page: params[:page])
    @categories = Category.all
    @projects = Project.all   
     
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task created!"
      redirect_to tasks_path
    end
  end

  private 
    def task_params
      params.require(:task).permit(:description, :billable, :hours, :category_id, :project_id)
    end
end
