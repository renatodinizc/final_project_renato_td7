class FreelancersController < ApplicationController
  def show
    @freelancer = current_freelancer
  end
end