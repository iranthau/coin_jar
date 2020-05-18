FactoryBot.define do
  factory :product do
    trait :eth do
      name { 'ETHAUD' }
    end

    trait :btc do
      name { 'BTCAUD' }
    end
  end
end