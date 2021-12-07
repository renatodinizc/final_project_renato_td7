class HomeController < ApplicationController
  def index
    @projects = Project.where(status: 'opened')
  end
end
