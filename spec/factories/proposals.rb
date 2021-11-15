FactoryBot.define do
  factory :proposal do
    proposal_description { 'Much justification'}
    hourly_wage { 42 }
    weekly_hours { 9 }
    expected_conclusion { 2.months.from_now }
    project
    freelancer
    contractor { project.contractor }

  end
end