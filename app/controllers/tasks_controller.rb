class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  PER = 5

  def index

    @search_params = task_search_params
    @tasks = Task.search(@search_params)

    if params[:sort_expired]
      @tasks = Task.sort_deadline
    elsif params[:sort_created]
      @tasks = Task.sort_created
    else
      @tasks = Task.sort_created
    end

    if params[:sort_priority]
      @tasks = Task.sort_priority
    else
      @tasks = Task.sort_created
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
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: 'タスクを登録しました'
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
    params.require(:task).permit(:title, :content, :deadline, :status, :priority )
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :status)
  end

end
