FactoryBot.define do
  factory :freelancer do
    sequence (:email) { |n| "freelancer#{n}@hub.com" }
    password {'123123'}
    sequence (:full_name) { |n| "Freelancer Full Name #{n}" }
    sequence (:social_name) { |n| "Freelancer #{n}" }
    birth_date { '27/03/1995'}
    degree { 'Engenharia' }
    description { 'Much description' }
    experience { 'Much experience' }
    freelancer_expertise
  end
end