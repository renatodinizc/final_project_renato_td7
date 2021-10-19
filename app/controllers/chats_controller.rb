class ChatsController < ApplicationController

  def index
    @chats = Chat.all
  end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @chat = @proposal.chats.new(params.require(:chat).permit(:commenter, :message))

    if @chat.save!
      redirect_to proposal_path(@proposal)
    end
  end
end

