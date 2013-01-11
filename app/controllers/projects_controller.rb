class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index

    @page = params[:page]
    @per_page = params[:per_page] ? params[:per_page] : 5
    @search = params[:search].to_s
    
    case params[:by].to_s.downcase
    when "tasks_quantity"
      @by = "tasks_quantity"
      @order_by = @by
    else
      @by = "name"
      @order_by = 'projects.' + @by
    end

    case params[:sort].to_s.upcase
    when "DESC"
      @sort = "DESC"
    else
      @sort = "ASC"
    end

    @projects = Project.joins('LEFT JOIN tasks ON tasks.project_id = projects.id').like_name(@search).order(@order_by + ' ' + @sort).paginate(:page => @page, :per_page => @per_page).select('projects.*, count(tasks.id) tasks_quantity').group('projects.id')
    @quantity = Project.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/ajaxnew
  # GET /projects/ajaxnew.json
  def ajaxnew
    @project = Project.new

    respond_to do |format|
      format.html { render :layout => false } # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
