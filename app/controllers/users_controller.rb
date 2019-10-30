class UsersController < ApplicationController
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
    if @user != current_user
      #@msg = "このページは閲覧できません．"
      flash.now[:danger] = "このページは閲覧できません．"
      render 'errors/show'
      return
    end
    render 'show'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
