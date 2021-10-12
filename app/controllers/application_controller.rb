class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    new_freelancer_path
  end

end
