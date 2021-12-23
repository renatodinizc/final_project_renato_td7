class Api::V1::ApiController < ActionController::API
  # Elencar erros do mais genérico ao mais específico
  rescue_from ActiveRecord::ActiveRecordError, with: :render_generic_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found
    render status: 404, json: '{ message:: Objeto não encontrado }'
  end

  def render_generic_error
    render status: 500, json: '{ message:: Erro geral }'
  end
end
