class Admin::UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :admin_user
    
    def new
      @user = User.new
    end

    def index
      @users = User.all.order(id: :asc)
    end

    def create
      @user = User.new(admin_user_params)
      if @user.save
        redirect_to admin_users_path, notice:  "作成しました!"
      else
        render :new
      end
    end

    def show
      @tasks = Task.all.includes(:user)
    end
  
    def edit
    end

    def update
      if @user.update(admin_user_params)
        redirect_to admin_users_path, notice: "更新しました"
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def admin_user_params
      params.require(:user).permit(:name, :email, :password,
      :password_confirmation, :admin)
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = "権限がありません"
        redirect_to tasks_path
      end
    end
end
