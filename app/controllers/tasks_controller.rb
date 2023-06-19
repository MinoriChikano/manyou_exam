class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired] 
      @tasks = Task.all.order(expired_at:"DESC")
    else
      @tasks = Task.all.order(created_at:"DESC")
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice:  "新規タスクを作成しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"削除しました"
  end

  def search
    if params[:keyword].present? && params[:status].present?
      @tasks = Task.search_by_keyword_and_status(params[:keyword], params[:status])
    elsif params[:keyword].present?
      @tasks = Task.search_by_keyword(params[:keyword])
    elsif params[:status].present?
      @tasks = Task.search_by_status(params[:status])
    else
      @tasks = Task.all
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :detail, :expired_at, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
