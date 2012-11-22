require 'goliath'

require 'em-synchrony'
require 'em-synchrony/em-http'

class Proxy < Goliath::API  
  use Goliath::Rack::Params

  def on_headers(env, headers) 
    env.logger.info 'proxying new request: ' + headers.inspect
    env['client-headers'] = headers
  end

  def response(env)
    params = {:head => env['client-headers'], :query => env.params}
    
    proxy_host = "http://localhost:3002"
    
    if env[Goliath::Request::REQUEST_PATH] =~ %r{^/push}
      proxy_host = "http://localhost:3001"
    end
       

    req = EM::HttpRequest.new("#{proxy_host}#{env[Goliath::Request::REQUEST_PATH]}")
    resp = case(env[Goliath::Request::REQUEST_METHOD])
      when 'GET' then req.get(params)
      when 'POST' then req.post(params.merge(:body => env[Goliath::Request::RACK_INPUT].read))
      else p "UNKNOWN METHOD #{env[Goliath::Request::REQUEST_METHOD]}"
    end

    response_headers = {}
    resp.response_header.each_pair do |k, v|
      response_headers[to_http_header(k)] = v
    end

    [resp.response_header.status, response_headers, resp.response]
  end
  
  def to_http_header(k)
    k.downcase.split('_').collect { |e| e.capitalize }.join('-')
  end
end
