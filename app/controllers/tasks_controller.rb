class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy ]

  def index
    @tags= Tag.all
    if params[:sort_expired]
      @tasks = @current_user.tasks.order(limit_date: :desc)
    elsif params[:sort_priority]
      @tasks = @current_user.tasks.order(priority: :desc)
    elsif params[:task].present?
      status = params[:task][:status]
      name= params[:task][:name]
        if params[:task][:label]!= ''
          tag_id = params[:task][:label]
          @tasks = Tag.find(tag_id).tagging_tasks
        elsif name!='' && status!=''
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
    @tags = @current_user.tags
  end

  def new
    @task = Task.new
    @tags = @current_user.tags
  end

  def edit
    @tags = @current_user.tags
    puts @tags
    @clicked_tags =  @task.tasks_tags
    puts @clicked_tags
    puts
    if @clicked_tags !=nil &&  @tags != nil
      not_my_tags = []
      @tags.each do |tag|
        # unless @clicked_tags.include?(tag)
          if ! appartient(@clicked_tags, tag)
            not_my_tags << tag
          end
      end
    end
    @tags = not_my_tags
  end

  def create
    @task = @current_user.tasks.build(task_params)

    if @task.save
      if params[:task][:tag_ids] != nil
        params[:task][:tag_ids].each do|id|
          Tagging.create(task_id: @task.id, tag_id: id)
        end
      end
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end



  def update
      if @task.update(task_params)
        #deleting taggings before_action
        to_delete = @task.taggings
        if to_delete != nil
          to_delete.each do |d|
            d.destroy
          end
        end
        #register according to taggings
        if params[:task][:tag_ids] != nil
          params[:task][:tag_ids].each do |id|
            Tagging.create(task_id: @task.id, tag_id: id)
          end
        end
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
      # @tags = @task.tags
    end
    def task_params
      task_params= params.require(:task).permit(:name, :limit_date, :status, :content, :priority, :tag_id)
      task_params[:priority] = params[:task][:priority].to_i
      return task_params
    end

    def appartient(tags,tag)
      tags.each do |t|
        if t.id == tag.id
          return true
        end
      end
      return false
    end

end
