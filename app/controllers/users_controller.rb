class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :login_user, only: [:new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] =@user.id
      redirect_to :root
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to :root
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
    :password_confirmation)
  end

  def login_user
    if current_user
      flash[:notice] = "ログイン済みです"
      redirect_to :root
    end
  end

end
