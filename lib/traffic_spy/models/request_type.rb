module TrafficSpy
  class RequestType
    attr_reader :request

    def initialize(request)
      @request    = request
    end

    def self.table
      DB.from(:requestedType)
    end

    def self.create(request)
      if !contains(request)
        table.insert(
        :request => request
        )
      end
      return_id(request)
    end

    def self.return_id(request)
      table.where(request: request).map{ |id| id[:id] }.first
    end


    def self.contains(request)
      !table.where(request: request).empty?
    end
  end
end
