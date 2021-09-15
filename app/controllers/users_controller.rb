class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :my_account, only: [:edit, :update, :destroy]
  before_action :connected, only: [:new, :create]
  skip_before_action :login_required, only:  [:new, :create]
  

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user), notice: "User was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
    
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User was successfully updated." 

    else
      render :edit, status: :unprocessable_entity 
      
    end

  end

  def destroy
    @user.destroy
    respond_to do |format|
      redirect_to users_url, notice: "User was successfully destroyed."
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def my_account
    if @current_user.id != params[:id] and !@current_user.admin
      redirect_to tasks_path
    end
  end

  def connected
    if logged_in? && @current_user.admin
      redirect_to tasks_path
    end
  end
end
