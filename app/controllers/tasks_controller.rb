class TasksController < ApplicationController
  def new
  end

  def create
  end

  def edit
    @task = Task.find(params[:id])
  end
end
