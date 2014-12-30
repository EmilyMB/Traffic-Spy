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

    post '/sources' do
      identifier = params[:identifier]
      rootUrl = params[:rootUrl]
      Sources.create(identifier,rootUrl)
      if identifier.nil? || rootUrl.nil?
        400
      else
        "#{identifier} and #{rootUrl}"
      end
    end

  end
end
