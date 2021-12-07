FactoryBot.define do
  factory :freelancer_expertise do
    sequence(:title) { |n| "Expertise #{n}" }
  end
end
