require_relative 'feature_test_helper'
module TrafficSpy

  Capybara.app = Server

  class IdentifierTest < FeatureTest
    include Rack::Test::Methods
    include Capybara::DSL

    def app
      Server
    end

    def test_error_when_status_missing_rootUrl
      post '/sources', "identifier=jumpstartlab"
      assert_equal 400, last_response.status
    end

    def test_error_when_status_missing_identifier
      post '/sources', "rootUrl=http://google.com"
      assert_equal 400, last_response.status
    end

    def test_application_registration
      post '/sources', "identifier=jumpstartlab&rootUrl=http://google.com"
      assert_equal 200, last_response.status
    end
  end
end
