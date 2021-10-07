class ProjectsController < ApplicationController
    def show
      @project = Project.find(params[:id])
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(params.require(:project).permit(:title, :description, :desired_skills,
                            :top_hourly_wage, :proposal_deadline, :remote))
      if @project.save
          redirect_to project_path(@project)
      else
        render :new
      end
    end
end