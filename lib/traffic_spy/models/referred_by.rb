module TrafficSpy
  class ReferredBy
    attr_reader :url, :count

    def initialize(url)
      @url    = url
    end

    def self.table
      DB.from(:referredBy)
    end

    def self.create(url)
      if contains(url)
        count_update(url)
      else
        table.insert(
        :url => url,
        :count    => 1
        )
      end
      return_id(url)
    end

    def self.return_id(url)
      table.where(url: url).map{ |id| id[:id]}.first
    end

    def self.count_update(url)
      table.where(url: url).update(:count => :count + 1)
    end

    def self.contains(url)
      !table.where(url: url).empty?
    end
  end
end
