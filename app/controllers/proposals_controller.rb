class ProposalsController < ApplicationController

  def show
    @proposal = Proposal.find(params[:id])
  end

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:proposal_description,
                            :hourly_wage, :weekly_hours, :expected_conclusion))
    @proposal.project = Project.find(params[:project_id])
    @proposal.freelancer = current_freelancer
    @proposal.contractor = Project.find(params[:project_id]).contractor
    @proposal.save

    flash[:errors] = "Todos campos devem ser preenchidos"
    redirect_to project_path @proposal.project
  end

  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(params.require(:proposal).permit(:denial_feedback))
    if @proposal.valid?(:feedback_submission)
      redirect_to project_path @proposal.project
    else
      render :deny
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    project = @proposal.project
    @proposal.destroy
    redirect_to project_path(project)
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
  end
end