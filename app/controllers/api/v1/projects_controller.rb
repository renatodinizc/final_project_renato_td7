module Api
  module V1
    class ProjectsController < ApiController
      def index
        @projects = Project.all
        render json: @projects.as_json(include: { contractor: { only: [:email] } })
      end

      def show
        @project = Project.find(params[:id])
        render json: @project
      end

      def create
        @project = Project.create(params.require(:project)
                                        .permit(:title, :description,
                                                :desired_skills,
                                                :top_hourly_wage,
                                                :proposal_deadline,
                                                :remote,
                                                :freelancer_expertise_id,
                                                :contractor_id))
        render json: @project, status: 201
      end
    end
  end
end
