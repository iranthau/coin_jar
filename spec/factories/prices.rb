FactoryBot.define do
  factory :price do
    association :product

    price { '302.200000000' }
    last_price { '311.90000000' }
    bid { '311.40000000' }
    ask { '312.10000000' }
  end
end
