module TrafficSpy
  class EventName
    attr_reader :event

    def initialize(event)
      @event    = event
    end

    def self.table
      DB.from(:eventName)
    end

    def self.create(event)
      if !contains(event)
        table.insert(
        :event => event,
        :count => 1
        )
      else
        count_update(event)
      end
      return_id(event)
    end

    def self.return_id(event)
      table.where(event: event).map{ |id| id[:id] }.first
    end

    def self.count_update(event)
      table.where(event: event).update(:count => :count + 1)
    end

    def self.contains(event)
      !table.where(event: event).empty?
    end
  end
end
