ENV['RACK_ENV'] = "test"

require 'sinatra'
require 'capybara'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'bundler'
Bundler.require

require_relative '../../lib/traffic_spy.rb'

Capybara.app = TrafficSpy::Server

class FeatureTest < Minitest::Test
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
    TrafficSpy.delete_all
  end
end
