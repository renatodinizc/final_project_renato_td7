class Project < ApplicationRecord
    belongs_to :contractor
    belongs_to :freelancer_expertise
    has_many :proposals

    validates :title, :description, :desired_skills, :top_hourly_wage, :proposal_deadline, presence: true
end
