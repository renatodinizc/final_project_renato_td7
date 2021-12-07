FactoryBot.define do
  factory :contractor do
    sequence(:email) { |n| "contractor#{n}@hub.com" }
    password { '123123' }
  end
end
