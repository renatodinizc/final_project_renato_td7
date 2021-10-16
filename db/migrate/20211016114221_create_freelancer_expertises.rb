class CreateFreelancerExpertises < ActiveRecord::Migration[6.1]
  def change
    create_table :freelancer_expertises do |t|
      t.string :title

      t.timestamps
    end
  end
end
