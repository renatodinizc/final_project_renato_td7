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
      @project.contractor = current_contractor
      if @project.save
          redirect_to(project_path(@project))
      else
        render :new
      end
    end

    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      if @project.update(params.require(:project).permit(:title, :description, :desired_skills,
                      :top_hourly_wage, :proposal_deadline, :remote))
        redirect_to project_path @project
      else
        render :edit
      end
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to root_path
    end
end