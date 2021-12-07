class FreelancersController < ApplicationController
  before_action :authenticate_freelancer!, :check_freelancer_identity,
                only: %i[edit update my_projects]
  before_action :authenticate_any!, :check_freelancer_identity, only: [:show]

  def show
    if freelancer_signed_in?
      @freelancer = current_freelancer
      @projects = @freelancer.projects.where(status: 'finished')
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
                                                          :birth_date, :degree, :description,
                                                          :experience, :freelancer_expertise_id))
    if @freelancer.valid?(:profile_completion)
      redirect_to freelancer_path(@freelancer)
    else
      render :edit
    end
  end

  def my_projects
    @proposals = Proposal.where(freelancer: current_freelancer)
  end

  private

  def check_freelancer_identity
    @freelancer = Freelancer.find(params[:id]) if current_freelancer
    return unless @freelancer && @freelancer.email != current_freelancer.email

    flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO AO PROFILE DE OUTROS FREELANCERS'
    redirect_to freelancer_path current_freelancer
  end
end
