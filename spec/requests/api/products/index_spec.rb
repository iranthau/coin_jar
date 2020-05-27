require 'rails_helper'

RSpec.describe 'GET /api/products', type: :request do
  describe 'GET /api/products' do
    subject(:perform_request) { get '/api/products', params: {}, headers: headers }

    let(:token) { JWT.encode(payload, Rails.application.secrets.secret_key_base) }
    let(:headers) do
      { Authorization: "Bearer #{token}" }
    end
    let(:payload) do
      {
        id: user.id,
      }
    end
    let!(:user) { FactoryBot.create(:user) }

    context 'when the user NOT authorised' do
      let(:payload) do
        {
          id: -1,
        }
      end
      let(:expected_response) do
        {
          errors: 'Not Authorised'
        }.to_json
      end

      it do
        expect { perform_request }.not_to change(Price, :count)

        expect(response).to have_http_status :unauthorized
        expect(response.body).to eq expected_response
      end
    end

    context 'when the user is authorised' do
      let!(:eth_product) { FactoryBot.create(:product, :eth) }
      let!(:btc_product) { FactoryBot.create(:product, :btc) }
      let!(:eth_price) do
        FactoryBot.create(
          :price,
          price: '234.00',
          last_price: '234.00',
          bid: '311.40000000',
          ask: '312.10000000',
          product: eth_product
        )
      end
      let!(:btc_price) do
        FactoryBot.create(
          :price,
          price: '1234.00',
          last_price: '231.90000000',
          bid: '232.40000000',
          ask: '123.10000000',
          product: btc_product
        )
      end
      let(:expected_response) do
        {
          products: {
            ETHAUD: '234.0',
            BTCAUD: '1234.0'
          }
        }.to_json
      end

      it do
        perform_request

        expect(response).to have_http_status :ok
        expect(response.body).to eq expected_response
      end
    end
  end
end