require 'rails_helper'

RSpec.describe 'GET /products', type: :request do
  describe 'GET /products' do
    subject(:perform_request) { get '/products' }

    context 'when there are NO products' do
      it 'renders the index page without products' do
        perform_request

        expect(response).to render_template :index
        expect(response.body).to include 'Capture'
        expect(response.body).to include 'Product Name'
        expect(response.body).to include 'Latest Price'
      end
    end

    context 'when there are products' do
      let!(:eth_product) { FactoryBot.create(:product, :eth) }
      let!(:btc_product) { FactoryBot.create(:product, :btc) }

      context 'when there are NO prices for products' do
        it 'renders the index page without prices' do
          perform_request

          expect(response).to render_template :index
          expect(response.body).to include 'Capture'
          expect(response.body).to include 'Product Name'
          expect(response.body).to include 'Latest Price'
          expect(response.body).to include 'ETHAUD'
          expect(response.body).to include 'BTCAUD'
          expect(response.body).to include 'Not Available'
          expect(response.body).to include 'Not Available'
        end
      end

      context 'when there are prices for products' do
        let!(:latest_eth_price) { FactoryBot.create(:price, price: '123.120000000', created_at: Time.zone.now, product: eth_product) }
        let!(:old_eth_price) { FactoryBot.create(:price, price: '234.230000000', created_at: 1.day.ago, product: eth_product) }
        let!(:latest_btc_price) { FactoryBot.create(:price, price: '1123.120000000', created_at: Time.zone.now, product: btc_product) }
        let!(:old_btc_price) { FactoryBot.create(:price, price: '1234.230000000', created_at: 1.day.ago, product: btc_product) }

        it 'renders the index page with products and prices' do
          perform_request

          expect(response).to render_template :index
          expect(response.body).to include 'Capture'
          expect(response.body).to include 'Product Name'
          expect(response.body).to include 'Latest Price'
          expect(response.body).to include 'ETHAUD'
          expect(response.body).to include 'BTCAUD'
          expect(response.body).to include '$123.12'
          expect(response.body).to include '$1,123.12'
        end
      end
    end
  end
end
