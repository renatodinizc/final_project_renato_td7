class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer

  validates :proposal_description, :hourly_wage, :weekly_hours, :expected_conclusion, presence: true
end
