class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :correct_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録完了！ ログインして使ってみましょう！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    render 'show'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください．"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      if @user != current_user
        flash.now[:danger] = "このページは閲覧できません．"
        render 'errors/show'
      end
    end
end
