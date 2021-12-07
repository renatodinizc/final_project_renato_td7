module Api
  module V1
    class ProjectsController < ActionController::API
      def index
        @projects = Project.all
        render json: @projects.as_json(include: { contractor: { only: [:email] } })
      end

      def show
        @project = Project.find(params[:id])
        render json: @project
      rescue StandardError
        render status: 404, json: '{ message:: Objeto não encontrado }'
      end
    end
  end
end

# outro modo de escrever o controler de api:
#
# class Api::V1::ProjectsController < ActionController::API
# end
#
