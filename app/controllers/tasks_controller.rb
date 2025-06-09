class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.all
    @task = Task.new
    @editing_task = Task.find(params[:edit_id]) if params[:edit_id]
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      redirect_to @task
    else
      render :index
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
