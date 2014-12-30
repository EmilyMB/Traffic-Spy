module TrafficSpy

  class Server < Sinatra::Base
    set :views, 'lib/views'

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      identifier = params[:identifier]
      rootUrl = params[:rootUrl]

      if identifier.nil? || rootUrl.nil?
        halt 400, "Missing Parameters"
      elsif !Sources.contains(identifier)
        halt 403, "Identifier already exists"
      else
        Sources.create(identifier,rootUrl)
        "{\"identifier\":\"#{identifier}\"}"
      end
    end

    post '/sources/:identifier/data' do
      payload = params[:payload]
      if Sources.contains(params[:identifier])
        halt 403, "Application not registered"
      elsif payload.nil?
        halt 400, "Missing Payload"
      elsif !Payload.contains(payload)
        halt 403, "Already recieved request"
      else
        Payload.create(payload)
        "OK"
      end
    end
  end
end
