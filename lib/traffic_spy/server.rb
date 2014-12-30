module TrafficSpy

  class Server < Sinatra::Base
    set :views, 'lib/views'

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    error 400 do
      "Missing Parameters"
    end

    error 403 do
      "Something is wrong with your Authentication"
    end

    post '/sources' do
      identifier = params[:identifier]
      rootUrl = params[:rootUrl]

      if identifier.nil? || rootUrl.nil?
        400
      elsif !Sources.contains(identifier)
        403
      else
        Sources.create(identifier,rootUrl)
        "{\"identifier\":\"#{identifier}\"}"
      end
    end

    post '/sources/:identifier/data' do
      payload = params[:payload]
      if Sources.contains(params[:identifier])
        403
      elsif payload.nil?
        400
      elsif
        #payload exists
      else
        "nice"
      "#{payload}"
      end
    end
  end
end
