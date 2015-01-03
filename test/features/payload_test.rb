require_relative 'feature_test_helper'
module TrafficSpy

  Capybara.app = Server

  class IdentifierTest < FeatureTest
    include Rack::Test::Methods
    include Capybara::DSL

    attr_reader :payload_string, :identifier


    def app
      Server
    end

    def setup
      @payload_string = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":45,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"scottISfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.66666\"}"
      @identifier = "identifier=jumpstartlab2&rootUrl=http://google.com"
    end

    def test_error_when_missing_payload
      post '/sources', identifier
      assert_equal 200, last_response.status
      post '/sources/jumpstartlab2/data'
      assert_equal 400, last_response.status
    end

    def test_already_recieved_request_when_duplicated_request
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      assert_equal 200, last_response.status
      post '/sources/jumpstartlab2/data', payload_string
      assert_equal 403, last_response.status
    end

    def test_error_when_application_not_registered
      post '/sources', identifier
      post '/sources/jumpstartlab5000/data', payload_string
      assert_equal 403, last_response.status
    end

    def test_OK_when_identifier_and_payload_posted
      post '/sources', identifier
      assert_equal 200, last_response.status
      post '/sources/jumpstartlab2/data', payload_string
      assert_equal 200, last_response.status
    end
  end
end
