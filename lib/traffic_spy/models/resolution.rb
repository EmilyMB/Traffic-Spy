module TrafficSpy
  class Resolution

    # def initialize(resolution)
    #   @resolution    = resolution
    # end

    def self.table
      DB.from(:resolution)
    end

    def self.create(width, height)
      resolution = "#{width} x #{height}"
      if !contains(resolution)
        table.insert(
        :resolution => resolution,
        :width    => width,
        :height => height
        )
      end
      return_id(resolution)
    end

    def self.return_id(resolution)
      table.where(resolution: resolution).map{ |id| id[:id]}.first
    end

    def self.contains(resolution)
      !table.where(resolution: resolution).empty?
    end
  end
end
