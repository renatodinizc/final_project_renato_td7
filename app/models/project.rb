class Project < ApplicationRecord
  belongs_to :contractor
  belongs_to :freelancer_expertise
  has_many :proposals
  has_many :chats, through: :proposals

  enum status: { opened: 0, closed: 10, finished: 20 }

  validates :title, :description, :desired_skills, :top_hourly_wage, :proposal_deadline,
            presence: true

  validate :positive_top_hourly_wage

  private

  def positive_top_hourly_wage
    errors.add(:top_hourly_wage, 'não pode ser negativo') if !top_hourly_wage.nil? && top_hourly_wage.negative?
  end
end
