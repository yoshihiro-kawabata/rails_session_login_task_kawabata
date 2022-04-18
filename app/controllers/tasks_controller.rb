class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    user_id = session[:user_id]
    @tasks = Task.joins(:user).where(tasks: { user_id: user_id})
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('.created')
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
      redirect_to tasks_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.destroyed')
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      user_id = session[:user_id]
      params.require(:task).permit(:title, :content).merge(user_id: user_id)
    end
end