class Project < ApplicationRecord
  belongs_to :contractor
  belongs_to :freelancer_expertise
  has_many :proposals

  validates :title, :description, :desired_skills, :top_hourly_wage, :proposal_deadline, presence: true

  validate :positive_top_hourly_wage

  private

  def positive_top_hourly_wage
    if top_hourly_wage != nil && top_hourly_wage < 0
      errors.add(:top_hourly_wage, 'não pode ser negativo')
    end
  end



end
