class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.string :proposal_description
      t.decimal :hourly_wage
      t.integer :weekly_hours
      t.date :expected_conclusion

      t.timestamps
    end
  end
end
