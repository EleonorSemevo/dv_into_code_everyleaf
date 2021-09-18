class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :is_admin

  def index
     @users = User.includes(:tasks)
     @users = @users.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
  def update
    if @user.update(admin_params)
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User was successfully destroyed."
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def admin_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:admin)
  end

  def is_admin
    unless @current_user.admin
      redirect_to tasks_path, notice: "Only admin can access this page"
    end
  end

end
