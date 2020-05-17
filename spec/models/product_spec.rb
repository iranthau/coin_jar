require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) do
    FactoryBot.create(
      :product,
      name: 'eth',
      price: 331.100000000,
      last: 314.10000000,
      bid: 313.80000000,
      ask: 315.40000000
    )
  end

  it { expect(product.name).to eq 'eth' }
  it { expect(product.price).to eq 331.1 }
  it { expect(product.last).to eq 314.1 }
  it { expect(product.bid).to eq 313.8 }
  it { expect(product.ask).to eq 315.4 }
end
