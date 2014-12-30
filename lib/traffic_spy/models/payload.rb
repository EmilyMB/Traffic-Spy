module TrafficSpy
  class Payload
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

    def self.contains(identifier)
      puts 'I am here'
      table.where(identifier: identifier).empty?
    end
  end
end
