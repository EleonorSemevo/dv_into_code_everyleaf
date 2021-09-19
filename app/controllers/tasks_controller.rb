class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy ]

  def index
    if params[:sort_expired]
      @tasks = @current_user.tasks.order(limit_date: :desc)
    elsif params[:sort_priority]
      @tasks = @current_user.tasks.order(priority: :desc)
    elsif params[:task].present?
      status = params[:task][:status]
      name= params[:task][:name]
        if name!='' && status!=''
           @tasks = @current_user.tasks.where('name like ? and status like ?', name, status)
        elsif name!=''
           @tasks = @current_user.tasks.where('name like ?', name)
        elsif status!=''
          @tasks = @current_user.tasks.where('status like ?', status)
        else
          @tasks = @current_user.tasks.order(created_at: :desc)
        end
    else
      @tasks = @current_user.tasks.order(created_at: :desc)
    end

   @tasks = @tasks.page(params[:page]).per(10)

  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @current_user.tasks.build(task_params)

    if @task.save
      params[:task][:tag_ids].each do|id|
        Tagging.create(task_id: @task.id, tag_id: id)
      end
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end



  def update
      if @task.update(task_params)
        redirect_to tasks_path, notice: "Task was successfully updated."
      else
         render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully destroyed."
  end

  def sort_dedline
    @tasks = Task.all.order(limit_date: :desc)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end
    def task_params
      task_params= params.require(:task).permit(:name, :limit_date, :status, :content, :priority, :tag_ids)
      task_params[:priority] = params[:task][:priority].to_i
      return task_params
    end
end
