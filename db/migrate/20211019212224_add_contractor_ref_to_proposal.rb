class AddContractorRefToProposal < ActiveRecord::Migration[6.1]
  def change
    add_reference :proposals, :contractor, null: false, foreign_key: true
  end
end
