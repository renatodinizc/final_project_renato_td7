class AddDenialFeedbackToProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :denial_feedback, :string
  end
end
