class FreelancerExpertise < ApplicationRecord
  has_many :freelancers

  validates :title, presence: true
end
