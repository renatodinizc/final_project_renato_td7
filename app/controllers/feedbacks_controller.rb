class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @feedback = Feedback.new(params.require(:feedback).permit(:body))
    @feedback.proposal = @proposal
    if @feedback.save
      redirect_to project_path @proposal.project
    else
      render :new
    end
  end
end