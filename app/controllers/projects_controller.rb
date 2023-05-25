class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @new_project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_url, notice: "Project was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
