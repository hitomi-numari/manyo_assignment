class TasksController < ApplicationController
  before_action :task_picture, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
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
    @picture.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def set_picture
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content)
  end

end