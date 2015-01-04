require_relative 'feature_test_helper'
module TrafficSpy

  Capybara.app = Server

  class UrlsTest < FeatureTest
    include Rack::Test::Methods
    include Capybara::DSL

    attr_reader :payload_string, :payload_string2, :identifier


    def app
      Server
    end

    def test_it_goes_to_error_page_with_no_events
      @identifier = "identifier=jumpstartlab2&rootUrl=http://google.com"
      post '/sources', identifier
      visit '/sources/jumpstartlab2/events'
      assert last_response.ok?
      assert page.has_content?("No events have been defined")
    end

    def test_shows_received_event
      @payload_string = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":15,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"scottISfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.66666\"}"
      @payload_string2 = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":45,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"POST\",\"parameters\":[],\"eventName\": \"scottISNTfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"15000\",\"ip\":\"63.29.66666\"}"
      @payload_string2 = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":45,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"POST\",\"parameters\":[],\"eventName\": \"scottISNTfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"15000\",\"ip\":\"63.29.66666\"}"
      @identifier = "identifier=jumpstartlab2&rootUrl=http://google.com"
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
      visit '/sources/jumpstartlab2/events'
      assert_equal 200, last_response.status

      within('#events') do
        assert page.has_content?('scottISfunny')
      end
    end
  end
end
