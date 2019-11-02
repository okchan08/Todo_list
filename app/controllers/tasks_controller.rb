class TasksController < ApplicationController
  before_action :logged_in
  before_action :correct_user, only: [:update, :edit]
  def new
    @task = current_user.tasks.build(deadline: Time.zone.now)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "登録しました"
      redirect_to current_user
    else
      @task.deadline = Time.zone.now
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "更新しました．"
      redirect_to edit_task_path(@task)
    else
      @task.reload
      flash[:error] = @task.errors.full_messages
      redirect_to edit_task_path(@task)
    end
  end

  private
    def task_params
      params.require(:task).permit(:content, :deadline, :status)
    end

    def logged_in
      redirect_to login_path if !logged_in?
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      if @task.nil?
        flash[:danger] = "不正な操作です．"
        redirect_to user_path(current_user)
      end
    end
end
