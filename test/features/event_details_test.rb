require_relative 'feature_test_helper'
module TrafficSpy

  Capybara.app = Server

  class EventDetailsTest < FeatureTest
    include Rack::Test::Methods
    include Capybara::DSL

    attr_reader :payload_string, :payload_string2, :identifier

    def app
      Server
    end

    def setup
      @payload_string = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 11:38:28 -0700\",\"respondedIn\":15,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"scottISfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.66666\"}"
      @payload_string2 = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 11:38:28 -0700\",\"respondedIn\":45,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"POST\",\"parameters\":[],\"eventName\": \"scottISNTfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"15000\",\"ip\":\"63.29.66666\"}"
      @identifier = "identifier=jumpstartlab2&rootUrl=http://google.com"
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
    end

    def test_error_page_when_event_not_defined
      visit '/sources/jumpstartlab2/events/bob'
      assert last_response.ok?
      assert page.has_content?("bob not defined")
      assert_equal find_link('Back to Application Events Index')[:href], "/sources/jumpstartlab2/events"
    end

    def test_shows_hourly_breakdown_of_visits
      visit '/sources/jumpstartlab2/events/scottISfunny'
      assert_equal 200, last_response.status
      page.all('tr').each do |tr|
        assert tr.has_content?("0") unless tr.has_content?("Hour") || tr.has_content?("11 am")
      end
    end

    def test_shows_total_visits
      visit '/sources/jumpstartlab2/events/scottISfunny'
      within("p#times_received") do
        assert page.has_content?('1')
      end
    end
  end
end
