class SessionsController < ApplicationController
  def new
    redirect_to current_user if logged_in?
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = "ログインしました"
      redirect_back_or @user
    else
      flash.now[:danger] = "ログイン情報が間違っています"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = "ログアウトしました"
    redirect_to root_url
  end
end
