class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

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

    respond_to do |format|
      if @user.save
         redirect_to user_path(@user), notice: "User was successfully created." 
      else
        render :new, status: :unprocessable_entity 
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
       redirect_to user_path(@user), notice: "User was successfully updated." 

      else
       render :edit, status: :unprocessable_entity 
        
      end
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
    params.require(:user).permit(:name, :email, :password_digest, :password)
  end
end
