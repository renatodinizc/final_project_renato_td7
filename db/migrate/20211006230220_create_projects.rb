class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :desired_skills
      t.decimal :top_hourly_wage
      t.date :proposal_deadline
      t.boolean :remote

      t.timestamps
    end
  end
end
