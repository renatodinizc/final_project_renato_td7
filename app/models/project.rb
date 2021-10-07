class Project < ApplicationRecord
    validates :title, :description, :desired_skills, :proposal_deadline, presence: true
end
