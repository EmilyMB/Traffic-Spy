module TrafficSpy
require 'json'

  class Payload
    attr_reader :payload,
                :url_id

    def initialize(payload)
      @payload            = payload

    end

    def self.table
      DB.from(:payload)
    end

    def self.create(payload)
      payload_hash = JSON.parse(payload)
      update_tables(payload_hash)
      table.insert(
      :raw_data    => payload,
      :url_id      => @url_id,
      :requestedAt => payload_hash['requestedAt'],
      :respondedIn =>  payload_hash['respondedIn'],
      :parameters  => payload_hash['parameters'],
      :ip          => payload_hash['ip']
      )
    end

    def self.contains(payload)
      table.where(raw_data: payload).empty?
    end

    def self.update_tables(payload_hash)
      @url_id               = Url.create(payload_hash['url'])
    #  @referredBy_id      =  ReferredBy.create(payload_hash['referredBy'])
      # @requestType_id     = payload_hash[:requestType]
      # @eventName_id       = payload_hash[:eventName]
      # @userAgent_id       = payload_hash[:userAgent]
      # @resolution_width   = payload_hash[:resolutionWidth]
      # @resolution_height  = payload_hash[:resolutionHeight]
    end
  end
end
