class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_task, only: [:edit, :update, :destroy]
  PER = 5

  def index
    # binding.pry
    @task_search_params = task_search_params
    @tasks = Task.all
    @tasks = @tasks.search(@task_search_params)

    if params[:sort_expired]
      @tasks = @tasks.sort_deadline
    elsif params[:sort_priority]
      @tasks = @tasks.sort_priority
    else
      @tasks = @tasks.sort_created
    end

    @tasks = @tasks.page(params[:page]).per(PER)

  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @task.save
        flash[:success] = "タスクを登録しました"
        redirect_to task_path(@task.id)
      else
        render :new
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      ender :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, {label_ids: []})
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :status, :label_id)
  end

end
