class RemoveDenialFeedbackFromProposals < ActiveRecord::Migration[6.1]
  def change
    remove_column :proposals, :denial_feedback, :string
  end
end
