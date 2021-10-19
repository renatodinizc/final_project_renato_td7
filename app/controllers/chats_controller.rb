class ChatsController < ApplicationController

  def show
  end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @chat = @proposal.chat
    redirect_to chat_path(@proposal)
  end
end