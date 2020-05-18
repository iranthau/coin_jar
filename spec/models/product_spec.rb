require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { FactoryBot.create(:product, :eth) }

  it { is_expected.to have_many(:prices) }
  it { expect(product.name).to eq 'ETHAUD' }
end
