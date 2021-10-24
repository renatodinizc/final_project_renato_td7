class AddArchivedPropToProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :archived, :boolean, null: false, default: false
  end
end
