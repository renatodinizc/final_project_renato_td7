class Freelancer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :proposals

  has_many :projects, through: :proposals


  validates :full_name, :social_name, :birth_date, :degree, :description, :experience, presence: true, on: :profile_completion

end
