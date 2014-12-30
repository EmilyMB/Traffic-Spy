module TrafficSpy
  class Url
    attr_reader :count,
                :url

    def initialize(url)
      @count  = 0
      @url    = url
    end

    def self.table
      DB.from(:url)
    end

    def self.create(url)
      if contains(url)
        count_update(url)
      else
        table.insert(
          :site_url => url,
          :count    => 1
        )
      end
      return_id(url)
    end

    def self.return_id(url)
      table.where(site_url: url).map{ |id| id[:id]}.first
    end

    def self.count_update(url)
      table.where(site_url: url).update(:count => :count + 1)
    end

    def self.contains(url)
      table.where(site_url: url).empty?
    end
  end
end
