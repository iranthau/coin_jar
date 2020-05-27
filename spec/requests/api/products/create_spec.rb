require 'rails_helper'

RSpec.describe 'POST /api/products', type: :request do
  describe 'POST /api/products' do
    subject(:perform_request) { post '/api/products' }

    let!(:eth_product) { FactoryBot.create(:product, :eth) }
    let!(:btc_product) { FactoryBot.create(:product, :btc) }
    let(:expected_response) do
      {
        products: [
          {
            id: eth_product.id,
            name: 'ETHAUD',
            prices: [{
                id: eth_product.prices.first.id,
                price: '302.2',
                last_price: '311.9',
                bid: '311.4',
                ask: '312.1',
                product_id: eth_product.id
            }]
          }, {
            id: btc_product.id,
            name: 'BTCAUD',
            prices: [{
              id: btc_product.prices.first.id,
              price: '1302.2',
              last_price: '1311.9',
              bid: '1311.4',
              ask: '1312.1',
              product_id: btc_product.id
            }]
          }
        ]
      }.to_json
    end
    let(:eth_fetcher_mock) { instance_double(CoinJar::ProductDetailsFetcher, perform: eth_product_prices) }
    let(:btc_fetcher_mock) { instance_double(CoinJar::ProductDetailsFetcher, perform: btc_product_prices) }
    let(:eth_product_prices) do
      {
        price: '302.200000000',
        last_price: '311.90000000',
        bid: '311.40000000',
        ask: '312.10000000'
      }
    end
    let(:btc_product_prices) do
      {
        price: '1302.200000000',
        last_price: '1311.90000000',
        bid: '1311.40000000',
        ask: '1312.10000000'
      }
    end

    before do
      allow(CoinJar::ProductDetailsFetcher).to receive(:new).with('ETHAUD') { eth_fetcher_mock }
      allow(CoinJar::ProductDetailsFetcher).to receive(:new).with('BTCAUD') { btc_fetcher_mock }
    end

    it do
      expect { perform_request }.to change(Price, :count).by(2)

      expect(response).to have_http_status :created
      expect(response.body).to eq expected_response

      expect(eth_fetcher_mock).to have_received(:perform)
      expect(btc_fetcher_mock).to have_received(:perform)
      expect(eth_product.prices.first.price).to eq 302.20
      expect(eth_product.prices.first.last_price).to eq 311.90
      expect(eth_product.prices.first.bid).to eq 311.40
      expect(eth_product.prices.first.ask).to eq 312.10
      expect(btc_product.prices.first.price).to eq 1302.20
      expect(btc_product.prices.first.last_price).to eq 1311.90
      expect(btc_product.prices.first.bid).to eq 1311.40
      expect(btc_product.prices.first.ask).to eq 1312.10
    end
  end
end