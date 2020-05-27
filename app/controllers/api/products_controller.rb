module Api
  class ProductsController < Api::ApiController
    def index
      products = {}

      Product.all.map do |product|
        products[product.name] = product.prices.latest.price
      end

      render json: { products: products }
    end

    def create
      @products = Product.all

      @products.each do |product|
        product_prices = CoinJar::ProductDetailsFetcher.new(product.name).perform

        product.prices.create(product_prices) if product_prices.present?
      end

      render json: @products, adapter: :json, status: :created
    end
  end
end