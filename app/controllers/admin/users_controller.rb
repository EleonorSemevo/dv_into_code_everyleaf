class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :is_admin

  def index
     @users = User.all
     @users = @users.page(params[:page]).per(10) 
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_params)
    @user.admin = true;
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end



  private
  def set_user
    @user = User.find_by(d: params[:id])
  end

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

  def is_admin
    unless @current_user.admin
      redirect_to tasks_path
    end
  end
  
end
