class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order(created_at: :desc)
    @new_project = Project.new
  end

  def edit
    @project = Project.find(params[:id])

  end

  def create
    @new_project = Project.new(project_params)

    if @new_project.save
      redirect_to projects_url, notice: "Project was successfully created"
    else
      @projects = Project.all.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to projects_path, notice: "Project was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    @project = Project.find(params[:id])

    if Projects::UpdateStatusService.new(project: @project, event: project_status_event_param).call
      redirect_to @project
    else
      render :show, alert: "Can't update the project status", status: :unprocessable_entity
    end
  end

  def show
    @project = Project.includes(:comments).find(params[:id])
    @new_comment = Comment.new(project: @project)
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def project_status_event_param
    params.require(:event).keys.first
  end
end
