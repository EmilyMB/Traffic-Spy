require_relative 'feature_test_helper'
module TrafficSpy

  Capybara.app = Server

  class ApplicationDetailsTest < FeatureTest
    include Rack::Test::Methods
    include Capybara::DSL

    attr_reader :payload_string, :identifier, :payload_string2


    def app
      Server
    end

    def setup
      @payload_string = "payload={\"url\":\"http://jumpstartlab2.com/blog/3\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":60,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"scottISfunny\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.66666\"}"
      @payload_string2 = "payload={\"url\":\"http://jumpstartlab2.com/blog/4\",\"requestedAt\":\"2013-02-16 10:38:28 -0700\",\"respondedIn\":50,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"scottISfunny\",\"userAgent\":\"Chrome/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.66666\"}"
      @identifier = "identifier=jumpstartlab2&rootUrl=http://google.com"
    end

    def test_page_contains_requested_urls
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
      assert_equal 200, last_response.status

      get '/sources/jumpstartlab2', payload_string
      assert_equal 200, last_response.status

      visit '/sources/jumpstartlab2'
      within('#urls') do
        assert page.has_content?('http://jumpstartlab2.com/blog/3')
        assert page.has_content?('http://jumpstartlab2.com/blog/4')
      end
    end

    def test_page_contains_browser_information
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
      assert_equal 200, last_response.status

      get '/sources/jumpstartlab2', payload_string
      assert_equal 200, last_response.status

      visit '/sources/jumpstartlab2'
      within('#browser') do
        assert page.has_content?('Mozilla/5.0')
        assert page.has_content?('Chrome/5.0')
        assert page.has_content?('Macintosh')
      end
    end

    def test_page_contains_resolution
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
      assert_equal 200, last_response.status

      get '/sources/jumpstartlab2', payload_string
      assert_equal 200, last_response.status

      visit '/sources/jumpstartlab2'
      within('#resolution') do
        assert page.has_content?('1920 x 1280')
        assert page.has_content?('2')
      end
    end

    def test_page_contains_response_time
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
      assert_equal 200, last_response.status

      get '/sources/jumpstartlab2', payload_string
      assert_equal 200, last_response.status

      visit '/sources/jumpstartlab2'
      within('#response_time') do
        assert page.has_content?('60')
        assert page.has_content?('50')
        assert page.has_content?('1')
      end
    end

    def test_page_contains_all_urls
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
      assert_equal 200, last_response.status

      get '/sources/jumpstartlab2', payload_string
      assert_equal 200, last_response.status

      visit '/sources/jumpstartlab2'
      within('#all_urls') do
        assert page.has_content?('http://jumpstartlab2.com/blog/3')
        assert page.has_content?('http://jumpstartlab2.com/blog/4')
      end
    end

    def test_page_contains_event_link
      post '/sources', identifier
      post '/sources/jumpstartlab2/data', payload_string
      post '/sources/jumpstartlab2/data', payload_string2
      assert_equal 200, last_response.status

      get '/sources/jumpstartlab2', payload_string
      assert_equal 200, last_response.status

      visit '/sources/jumpstartlab2'
      within('#event_link') do
        assert page.has_content?('Click for all event data')
      end
    end
  end
end
