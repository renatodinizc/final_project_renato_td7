class AddExpertiseRefToFreelancer < ActiveRecord::Migration[6.1]
  def change
    add_reference :freelancers, :freelancer_expertise, null: true, foreign_key: true
  end
end
