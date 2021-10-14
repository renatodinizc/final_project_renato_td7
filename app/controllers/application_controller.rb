class ApplicationController < ActionController::Base 

  def get_search_input
    params[:search].strip
  end

  # Investigar problema do uso do current_freelancer.valid?(:profile_completion) no método caso dê tempo
  def after_sign_in_path_for(resource)
    if freelancer_signed_in?
      edit_freelancer_path current_freelancer
    elsif contractor_signed_in?
    root_path
    end
  end

  
  

end
