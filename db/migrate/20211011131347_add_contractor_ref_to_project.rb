class AddContractorRefToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :contractor, null: false, foreign_key: true
  end
end
