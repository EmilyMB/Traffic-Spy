module TrafficSpy
  class UserAgent
    attr_reader :full_data

    def initialize(full_data)
      @full_data    = full_data
    end

    def self.table
      DB.from(:userAgent)
    end

    def self.create(full_data)
      if !contains(full_data)
        table.insert(
        :full_data => full_data,
        :os    => full_data.split('(')[1].split(";")[0],
        :browser => full_data.split[0]
        )
      end
      return_id(full_data)
    end

    def self.return_id(full_data)
      table.where(full_data: full_data).map{ |id| id[:id]}.first
    end

    def self.contains(full_data)
      !table.where(full_data: full_data).empty?
    end
  end
end
