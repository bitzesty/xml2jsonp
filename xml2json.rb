require 'rubygems'
require 'sinatra'
require 'crack'
require 'json'
require 'rack/contrib/jsonp'
require 'open-uri'

use Rack::JSONP

TIME_OUT = 15
 
before do
  content_type :json
end

get '/' do
  begin
    if (params['callback'].blank? || params['url'].blank?)
      "#{params['callback']}({'error' : 'Must include url and callback'})"
    else
      Timeout::timeout(TIME_OUT) do
        resp = open(params['url']).read
        xml = Crack::XML.parse(resp)
        "#{params['callback']}(#{xml.to_json})" 
      end
    end
  rescue Timeout::Error
    "#{params['callback']}({'error' : 'Requesting the json took too long. Time limit is #{TIME_OUT} seconds.'})"
  rescue Errno::ENOENT => e
    "#{params['callback']}({'error' : 'Problem requesting the json: #{e}'})"
  rescue Exception => e
    "#{params['callback']}({'error' : 'A problem ocurred: #{e}'})"
  end
end