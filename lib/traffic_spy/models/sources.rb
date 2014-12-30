module TrafficSpy
  class Sources
    attr_reader :identifier,
                :rootUrl

    def initialize(identifier, rootUrl)
      @identifier = identifier
      @rootUrl    = rootUrl
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
  end
end
