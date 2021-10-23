class AddProposalRefToFeedback < ActiveRecord::Migration[6.1]
  def change
    add_reference :feedbacks, :proposal, null: false, foreign_key: true
  end
end
