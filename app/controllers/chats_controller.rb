class ChatsController < ApplicationController

  #def index
  #  @chats = Chat.all
  #end

  def create
    @chat = Chat.new
    @proposal = Proposal.find(params[:proposal_id])
    @chat = @proposal.chats.new(params.require(:chat).permit(:message))
    if current_contractor
      @chat.commenter = current_contractor.email
    elsif current_freelancer
      @chat.commenter = current_freelancer.social_name
    end

    if @chat.save
      redirect_to proposal_path(@proposal)
    end
  end
end

