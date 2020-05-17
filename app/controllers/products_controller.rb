# frozen_string_literal: true

class ProductsController < ApplicationController
  PRODUCTS = %w[ETHAUD BTCAUD].freeze

  def capture
    PRODUCTS.each do |product|
      product_attributes = CoinJar::ProductDetailsFetcher.new(product).perform

      Product.create(product_attributes.merge(name: product))
    end

    redirect_to products_path
  end

  def index
    @products = Product.all
  end
end
