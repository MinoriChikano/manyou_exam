class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy,]

  def index
    @tasks = current_user.tasks.order(created_at:"DESC").page(params[:page]).per(10)
    if params[:sort_expired]
      @tasks = current_user.tasks.order(expired_at:"DESC").page(params[:page]).per(10)
    end

    if params[:sort_priority]
      @tasks = current_user.tasks.order(priority:"ASC").page(params[:page]).per(10)
    end

    if params[:label_id].present?
      @labelling =Labelling.where(label_id: params[:label_id]).pluck(:task_id)
      @tasks=@tasks.where(id: @labelling)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice:  "新規タスクを作成しました!"
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
    if params[:task_name].present? && params[:status].present?
      @tasks = Task.search_by_name_and_status(params[:task_name], params[:status])
    elsif params[:task_name].present?
      @tasks = Task.search_by_name(params[:task_name])
    elsif params[:status].present?
      @tasks = Task.search_by_status(params[:status])
    else
      redirect_to tasks_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :detail, :expired_at, :status, :priority, label_ids:[])
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
