# frozen_string_literal: true

module CoinJar
  class ProductDetailsFetcherError < StandardError; end

  class ProductDetailsFetcher
    def initialize(product_name)
      raise CoinJar::ProductDetailsFetcherError, 'a product name is required' if product_name.blank?

      @product_name = product_name
    end

    def perform
      response = RestClient.get("#{Rails.configuration.coin_jar_products_url}/#{product_name}/ticker")
      product_attributes = JSON.parse(response.body).with_indifferent_access

      {
        price: product_attributes[:volume_24h],
        last: product_attributes[:last],
        bid: product_attributes[:bid],
        ask: product_attributes[:ask]
      }
    rescue RestClient::ExceptionWithResponse => e
      raise CoinJar::ProductDetailsFetcherError, e.response.body
    end

    private

    attr_reader :product_name
  end
end