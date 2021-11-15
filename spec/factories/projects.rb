FactoryBot.define do
  factory :project do
    sequence (:title) { |n| "Project #{n}" }
    sequence (:description) { |n| "Description #{n}" }
    desired_skills { 'Much skills'}
    top_hourly_wage { 97 }
    proposal_deadline { 1.month.from_now }
    remote { true }
    contractor
    freelancer_expertise
  end
end