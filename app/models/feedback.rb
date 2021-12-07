class Feedback < ApplicationRecord
  belongs_to :proposal

  validates :body, presence: true, length: { minimum: 10 }
end
