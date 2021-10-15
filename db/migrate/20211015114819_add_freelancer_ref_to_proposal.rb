class AddFreelancerRefToProposal < ActiveRecord::Migration[6.1]
  def change
    add_reference :proposals, :freelancer, null: false, foreign_key: true
  end
end
