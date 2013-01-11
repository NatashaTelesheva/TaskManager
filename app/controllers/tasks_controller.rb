class TasksController < ApplicationController
  # GET projects/1/tasks
  # GET projects/1/tasks.json
  def index
    
    @page = params[:page]
    @per_page = params[:per_page] ? params[:per_page] : 5
    @search = params[:search].to_s

    case params[:by].to_s.downcase
    when "status"
      @by = "status"
    else
      @by = "name"
    end
    
    case params[:sort].to_s.upcase
    when "DESC"
      @sort = "DESC"
    else
      @sort = "ASC"
    end

    @project = Project.find(params[:project_id])
    @tasks = Task.where(:project_id => @project.id).like_name(@search).order(@by + ' ' + @sort).paginate(:page => @page, :per_page => @per_page)
    @quantity = Task.where(:project_id => @project.id).count
    @statuses = Task.where(:project_id => @project.id).select('status, count(*) quantity').group('status');

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tasks }
    end
  end

  # GET projects/1/tasks/1
  # GET projects/1/tasks/1.json
  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @task }
    end
  end

  # GET projects/1/tasks/new
  # GET projects/1/tasks/new.json
  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @task }
    end
  end

  # GET projects/1/tasks/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  # POST projects/1/tasks
  # POST projects/1/tasks.json
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to([@task.project, @task], :notice => 'Task was successfully created.') }
        format.json { render :json => @task, :status => :created, :location => [@task.project, @task] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT projects/1/tasks/1
  # PUT projects/1/tasks/1.json
  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to([@task.project, @task], :notice => 'Task was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE projects/1/tasks/1
  # DELETE projects/1/tasks/1.json
  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_url(project) }
      format.json { head :ok }
    end
  end
end
