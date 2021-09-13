class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy ]

  def index
    if params[:sort_expired]
      @tasks = Task.get_all
    elsif params[:sort_priority]
      @tasks = Task.sort_priority
    elsif params[:task].present?
      status = params[:task][:status]
      name= params[:task][:name]
        if name!='' && status!=''
			     @tasks = Task.name_status_search(name,status)
        elsif name!=''
			     @tasks = Task.search_name(name)
        elsif status!=''
			    @tasks = Task.search_status(status)
			  else
			    @tasks = Task.all.order(created_at: :desc)
        end
    else
      @tasks = Task.all.order(created_at: :desc)
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
    @task = Task.new(task_params)
    if @task.save
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
      task_params= params.require(:task).permit(:name, :limit_date, :status, :content, :priority)
      task_params[:priority] = params[:task][:priority].to_i
      return task_params
    end
end
