class PricesController < ApplicationController
  def index
    @product = Product.find(params[:product_id])

    @prices = @product.prices.order(created_at: :desc)
  end
end
