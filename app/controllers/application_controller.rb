class ApplicationController < ActionController::Base 

  def get_search_input
    params[:search].strip
  end

  def authenticate_any!
    if contractor_signed_in?
        true
    else
        authenticate_freelancer!
    end
  end

  # Solução refatorada. Usuário ja é direcionado para root_path com perfil completo, mas ainda passa pela tela repetida
  # de login caso não esteja com cadastro completo. É necessário rodar um F5
  def after_sign_in_path_for(resource)
    return root_path if resource.is_a? Contractor
    if resource.valid?(:profile_completion)
      root_path
    else
      edit_freelancer_path resource
    end
  end



end
