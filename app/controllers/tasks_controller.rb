class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      flash[:notice] = "新規タスクを作成しました"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :detail)
  end

end
