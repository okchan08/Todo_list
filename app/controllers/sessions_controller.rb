class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      flash[:success] = "ログインしました"
      redirect_to @user
    else
      flash.now[:danger] = "ログイン情報が間違っています"
      render 'new'
    end
  end
end
