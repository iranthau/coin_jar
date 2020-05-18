# frozen_string_literal: true

class ProductsController < ApplicationController
  def capture
    Product.all.each do |product|
      product_prices = CoinJar::ProductDetailsFetcher.new(product.name).perform

      product.prices.create(product_prices) if product_prices.present?
    end

    redirect_to products_path
  end

  def index
    @products = Product.all
  end
end
