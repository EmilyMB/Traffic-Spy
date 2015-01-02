module TrafficSpy
  class Sources
    attr_reader :identifier,
                :rootUrl

    def initialize(identifier)
      @identifier = identifier
      # @rootUrl    = rootUrl
    end

    def self.table
      DB.from(:sources)
    end

    def self.create(identifier, rootUrl)
      table.insert(
        :identifier => identifier,
        :rootUrl    => rootUrl
      )
    end

    def self.contains(identifier)
      table.where(identifier: identifier).empty?
    end

    def self.find_all_by_identifier(identifier)
      Sources.new(identifier)
    end

    def payloads
      DB.from(:payload).where(identifier: identifier)
    end

    def urls
      payloads.join(DB.from(:url), :id => :url_id)
    end

    def browsers
      payloads.join(DB.from(:userAgent), :id => :userAgent_id)
    end

    def resolutions
      payloads.join(DB.from(:resolution), :id => :resolution_id)
    end

    def response_times
      payloads.order(Sequel.desc(:respondedIn))
    end

    def events
      payloads.join(DB.from(:eventName), :id => :eventName_id)
    end

    def self.relative_path?(identifier,relative, path=nil)
      found_url = false
      if path.nil?
        find_all_by_identifier(identifier).urls.each do |url|
          found_url = true unless url[:site_url].split('/')[-1] != relative
        end
      else
        relative_path = relative.insert(-1, "\/#{path}")
        puts relative_path
        find_all_by_identifier(identifier).urls.each do |url|
          found_url = true unless url[:site_url].split('/')[-2] + "/" + url[:site_url].split('/')[-1] != relative_path
        end
      end
      found_url
    end

    def self.find_all_by_relative_path(identifier, relative, path=nil)
      results = []
      if path.nil?
        find_all_by_identifier(identifier).urls.each do |url|
          results << url if url[:site_url].split('/')[-1] == relative
        end
      else
        find_all_by_identifier(identifier).urls.each do |url|
          puts "Url #{url}"
          results << url if url[:site_url].split('/')[-2] + '/' + url[:site_url].split('/')[-1] == relative
          puts "HI string: #{url[:site_url].split('/')[-2]}" + '/' + "#{url[:site_url].split('/')[-1]}"
          puts "relative: #{relative}"
        end
      end
      puts "results: #{results}"
      results
    end

    def self.request_types
      DB.from(:requestedType)
    end

    def self.referred_by
      DB.from(:referredBy)
    end

    def self.user_agents
      DB.from(:userAgent)
    end
  end
end
