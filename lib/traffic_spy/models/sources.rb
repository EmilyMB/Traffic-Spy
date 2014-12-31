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

    def self.find_by_identifier(identifier)
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
  end
end
