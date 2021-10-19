class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer
  belongs_to :contractor
  has_many :chats

  validates :proposal_description, :hourly_wage, :weekly_hours, :expected_conclusion, presence: true
  enum status: {pending_approval: 0, proposal_approved: 10, proposal_denied: 20}
  validate :check_for_top_wage

  validates :denial_feedback, presence: true, length: {minimum: 10}, on: :feedback_submission

  private

  def check_for_top_wage
    if hourly_wage && project.top_hourly_wage < self.hourly_wage
      errors.add(:hourly_wage, 'não pode exceder o máximo preço por hora do projeto')
    end
  end 

end
