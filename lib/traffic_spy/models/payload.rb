module TrafficSpy
  class Payload
    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def self.table
      DB.from(:payload)
    end

    def self.create(payload)
      table.insert(
      :raw_data => payload
      )
    end

    def self.contains(payload)
      table.where(raw_data: payload).empty?
    end
  end
end
