FactoryBot.define do
  factory :feedback do
    body { 'Decidi recusar sua proposta' }
    proposal
  end
end
