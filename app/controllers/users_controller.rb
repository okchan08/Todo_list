class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    render 'new'
  end

  private
    def user_params
      params[:user].permit(:name, :email, :password, :password_confirmation)
    end
end
