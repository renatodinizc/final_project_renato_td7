class FreelancersController < ApplicationController
  before_action :authenticate_freelancer!, only: [:edit, :update, :my_projects]
  before_action :authenticate_any!, only: [:show]

  def show
    if freelancer_signed_in?
      @freelancer = current_freelancer
    elsif contractor_signed_in?
      @freelancer = Freelancer.find(params[:id])
    end
  end

  def edit
    @freelancer = current_freelancer
  end

  def update
    @freelancer = current_freelancer
    @freelancer.update(params.require(:freelancer).permit(:full_name, :social_name,
                        :birth_date, :degree, :description, :experience, :freelancer_expertise_id))
    if @freelancer.valid?(:profile_completion)
      redirect_to freelancer_path(@freelancer)
    else
      render :edit
    end
  end

  def my_projects
    @proposals = Proposal.where(freelancer: current_freelancer)
  end
  
end