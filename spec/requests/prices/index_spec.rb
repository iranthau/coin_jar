require 'rails_helper'

RSpec.describe 'GET /products/:product_id/prices', type: :request do
  describe 'GET /products/:product_id/prices' do
    subject(:perform_request) { get "/products/#{product_id}/prices" }

    let(:product_id) { 123 }

    context 'when the product is NOT found' do
      it 'raises not found error' do
        expect { perform_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the product is found' do
      let!(:eth_product) { FactoryBot.create(:product, :eth, id: 123) }

      context 'when there are NO prices for the product' do
        it 'renders the index page without prices' do
          perform_request

          expect(response).to render_template :index
          expect(response.body).to include 'ETHAUD'
          expect(response.body).to include 'Price'
          expect(response.body).to include 'Last Price'
          expect(response.body).to include 'Bid'
          expect(response.body).to include 'Ask'
        end
      end

      context 'when there are prices for the product' do
        let!(:latest_eth_price) do
          FactoryBot.create(
            :price,
            price: '123.120000000',
            last_price: '311.90000000',
            bid: '311.40000000',
            ask: '312.10000000',
            product: eth_product
          )
        end
        let!(:old_eth_price) do
          FactoryBot.create(
            :price,
            price: '234.230000000',
            last_price: '231.90000000',
            bid: '232.40000000',
            ask: '123.10000000',
            product: eth_product
          )
        end

        it 'renders the index page with prices' do
          perform_request

          expect(response).to render_template :index
          expect(response.body).to include 'ETHAUD'
          expect(response.body).to include 'Price'
          expect(response.body).to include 'Last Price'
          expect(response.body).to include 'Bid'
          expect(response.body).to include 'Ask'

          expect(response.body).to include '$123.12'
          expect(response.body).to include '$311.90'
          expect(response.body).to include '$311.40'
          expect(response.body).to include '$312.10'

          expect(response.body).to include '$234.23'
          expect(response.body).to include '$231.90'
          expect(response.body).to include '$232.40'
          expect(response.body).to include '$123.10'
        end
      end
    end
  end
end
