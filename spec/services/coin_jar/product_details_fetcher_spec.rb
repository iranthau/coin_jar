# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoinJar::ProductDetailsFetcher do
  subject(:fetcher) { described_class.new(product_name) }

  let(:product_name) { nil }

  describe '.new' do
    context 'when a product is NOT given' do
      it 'raises an error' do
        expect { fetcher }.to raise_error(CoinJar::ProductDetailsFetcherError, 'a product name is required')
      end
    end

    context 'when a product is given' do
      let(:product_name) { 'ETHAUD' }

      it 'raises an error' do
        expect(fetcher).to be_a(CoinJar::ProductDetailsFetcher)
      end
    end
  end

  describe '#perform' do
    subject(:perform) { fetcher.perform }

    let(:product_name) { 'ETHAUD' }
    let(:response_body) do
      {
        volume_24h: '302.200000000',
        volume: '39.400000000',
        transition_time: '2020-05-16T07:50:00Z',
        status: 'continuous',
        session: '2404',
        prev_close: '305.45000000',
        last: '311.90000000',
        current_time: '2020-05-16T07:48:29.380570Z',
        bid: '311.40000000',
        ask: '312.10000000'
      }.to_json
    end
    let(:response_code) { 200 }

    before do
      stub_request(:get, 'https://data.exchange.coinjar.com/products/ETHAUD/ticker').to_return(body: response_body, status: response_code)
    end

    context 'when there are NO errors' do
      let(:product_attributes) do
        {
          price: '302.200000000',
          last: '311.90000000',
          bid: '311.40000000',
          ask: '312.10000000'
        }
      end

      it 'returns product arributes' do
        expect(perform).to eq product_attributes
      end
    end

    context 'when there are errors' do
      let(:response_body) do
        {
          error_type: 'NOT_FOUND',
          error_messages: [
              'Record not found.'
          ]
        }.to_json
      end
      let(:response_code) { 404 }

      it 'raises an error' do
        expect { perform }.to raise_error(CoinJar::ProductDetailsFetcherError, response_body)
      end
    end
  end
end