require 'rails_helper'

RSpec.describe Price, type: :model do
  it { is_expected.to belong_to(:product) }

  describe '.latest' do
    subject(:latest) { described_class.latest }

    context 'when there are NO prices' do
      it { is_expected.to eq [] }
    end

    context 'when there are prices' do
      let!(:latest_price) { FactoryBot.create(:price, price: '123.120000000', created_at: Time.zone.now) }
      let!(:old_price) { FactoryBot.create(:price, price: '234.230000000', created_at: 1.day.ago) }

      it { is_expected.to eq latest_price }
    end
  end
end
