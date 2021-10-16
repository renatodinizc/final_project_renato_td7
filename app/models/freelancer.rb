class Freelancer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  belongs_to :freelancer_expertise, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :proposals

  has_many :projects, through: :proposals
  validates :full_name, :social_name, :birth_date, :degree, :description, :experience, :freelancer_expertise, presence: true, on: :profile_completion
  validate :check_if_underage

  private

  def check_if_underage
    if birth_date.present? && birth_date > 18.years.ago
      errors.add(:birth_date, "deve ser anterior a #{I18n.l 18.years.ago}")
    end
  end

end
