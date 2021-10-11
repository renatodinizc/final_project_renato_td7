class Project < ApplicationRecord
    belongs_to :contractor

    validates :title, :description, :desired_skills, :top_hourly_wage, :proposal_deadline, presence: true
end
