class ChatsController < ApplicationController
  # def index
  #  @chats = Chat.all
  # end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @chat = @proposal.chats.new(params.require(:chat).permit(:message))
    fetch_commenter
    redirect_to proposal_path(@proposal) if @chat.save
  end

  private

  def fetch_commenter
    if current_contractor
      @chat.commenter = current_contractor.email
    elsif current_freelancer
      @chat.commenter = current_freelancer.social_name
    end
  end
end
