class ProposalsController < ApplicationController

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:proposal_description,
                            :hourly_wage, :weekly_hours, :expected_conclusion))
    @proposal.project = Project.find(params[:project_id])
    @proposal.freelancer = current_freelancer
    @proposal.save

    flash[:errors] = "Todos campos devem ser preenchidos"
    redirect_to project_path @proposal.project
  end

  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update(params.require(:proposal).permit(:denial_feedback))
      redirect_to project_path @proposal.project
    else
      render :deny
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    redirect_to project_path @project
  end

  def accept
    @proposal = Proposal.find(params[:id])
    @proposal.proposal_approved!
    @proposal.save
    redirect_to project_path @proposal.project
  end

  def deny
    @proposal = Proposal.find(params[:id])
    @proposal.proposal_denied!
    @proposal.save
  end
end