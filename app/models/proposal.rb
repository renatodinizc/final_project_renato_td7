class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer


  validates :proposal_description, :hourly_wage, :weekly_hours, :expected_conclusion, presence: true

  validate :check_for_top_wage

  private

  def check_for_top_wage
    if hourly_wage && project.top_hourly_wage < self.hourly_wage
      errors.add(:hourly_wage, 'não pode exceder o máximo preço por hora do projeto')
    end
  end 

end
