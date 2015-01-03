ENV['RACK_ENV'] = "test"

require 'sinatra'
require 'capybara'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'bundler'
require 'nokogiri'
Bundler.require

require_relative '../../lib/traffic_spy.rb'

module TrafficSpy

  Capybara.app = Server

  class FeatureTest < Minitest::Test
    include Capybara::DSL

    def teardown
      Capybara.reset_sessions!
      Capybara.use_default_driver
      DB[:sources].delete
      DB[:payload].delete
    end
  end
end
