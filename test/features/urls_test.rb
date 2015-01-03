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

    def setup
      @payload_string = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":15,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"scottISfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.66666\"}"
      @payload_string2 = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":45,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"POST\",\"parameters\":[],\"eventName\": \"scottISNTfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"15000\",\"ip\":\"63.29.66666\"}"
      @identifier = "identifier=jumpstartlab2&rootUrl=http://google.com"
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
    end

    def test_error_page_when_url_not_defined
      visit '/sources/jumpstartlab2/urls/bob'
      assert last_response.ok?
      assert page.has_content?("URL has not been requested")
    end

    def test_shows_longest_response_time
      visit '/sources/jumpstartlab2/urls/blog/3'
      assert_equal 200, last_response.status
      within(:css, "p#longest_response") do
        assert page.has_content?('45')
      end
    end

    def test_shows_shortest_response_time
      visit '/sources/jumpstartlab2/urls/blog/3'
      within(:css, "p#shortest_response") do
        assert page.has_content?('15')
      end
    end

    def test_shows_average_response_time
      visit '/sources/jumpstartlab2/urls/blog/3'
      within(:css, "p#avg_response") do
        assert page.has_content?('30')
      end
    end

    def test_shows_http_verbs
      visit '/sources/jumpstartlab2/urls/blog/3'
      within(:css, "p#verbs") do
        assert page.has_content?('GET')
        assert page.has_content?('POST')
      end
    end

    def test_shows_referred_by
      visit '/sources/jumpstartlab2/urls/blog/3'
      within(:css, "p#referred_by") do
        assert page.has_content?('http://jumpstartlab.com')
      end
    end

    def test_shows_user_agents
      visit '/sources/jumpstartlab2/urls/blog/3'
      within(:css, "p#user_agents") do
        assert page.has_content?('Browser: Mozilla/5.0')
        assert page.has_content?('OS: Macintosh')
      end
    end
  end
end
