# frozen_string_literal: true

require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
Bundler.require(*Rails.groups)

module CoinJar
  class Application < Rails::Application
    config.load_defaults 6.0
    config.generators.system_tests = nil

    config.coin_jar_products_url = 'https://data.exchange.coinjar.com/products'
  end
end
