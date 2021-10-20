class Chat < ApplicationRecord
  belongs_to :proposal

  validates :commenter, :message, presence: true
end
