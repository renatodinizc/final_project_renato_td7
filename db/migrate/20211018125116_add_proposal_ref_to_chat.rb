class AddProposalRefToChat < ActiveRecord::Migration[6.1]
  def change
    add_reference :chats, :proposal, null: false, foreign_key: true

    validates :commenter, :message, presence: true
  end
end
