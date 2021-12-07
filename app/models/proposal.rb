class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer
  belongs_to :contractor
  has_many :chats
  has_one :feedback

  validates :freelancer_id, uniqueness: { scope: :project_id, conditions: lambda {
                                                                            where(archived: false)
                                                                          }, message:
                          'não pode enviar mais de uma proposta simultânea para mesmo projeto' }
  validates :proposal_description, :hourly_wage, :weekly_hours, :expected_conclusion, presence: true
  enum status: { pending_approval: 0, proposal_approved: 10, proposal_denied: 20,
                 proposal_forfeit: 30 }
  validate :check_for_top_wage, :check_validity_of_expected_conclusion

  # validates :denial_feedback, presence: true, length: {minimum: 10}, on: :feedback_submission

  private

  def check_for_top_wage
    return unless hourly_wage && project.top_hourly_wage <= hourly_wage

    errors.add(:hourly_wage, 'não pode exceder o máximo preço por hora do projeto')
  end

  def check_validity_of_expected_conclusion
    check_if_past
    if expected_conclusion && expected_conclusion == project.proposal_deadline
      errors.add(:expected_conclusion,
                 'não pode ser no mesmo dia do prazo de submissão final do projeto')
    elsif expected_conclusion && expected_conclusion < project.proposal_deadline
      errors.add(:expected_conclusion, 'não pode ser antes do prazo de submissão final do projeto')
    end
  end

  def check_if_past
    return unless expected_conclusion && expected_conclusion < Date.today

    errors.add(:expected_conclusion, 'não pode ser no passado')
  end
end
