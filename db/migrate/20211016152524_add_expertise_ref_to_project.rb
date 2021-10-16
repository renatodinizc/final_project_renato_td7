class AddExpertiseRefToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :freelancer_expertise, null: false, foreign_key: true
  end
end
