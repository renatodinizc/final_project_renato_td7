class ProposalsController < ApplicationController

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:proposal_description,
                            :hourly_wage, :weekly_hours, :expected_conclusion))
    @proposal.project = Project.find(params[:project_id])
    @proposal.save!
    
    redirect_to project_path @proposal.project
  end
end