class FreelancersController < ApplicationController
  def show
    @freelancer = current_freelancer
  end

  def new
    @freelancer = Freelancer.new
  end
end