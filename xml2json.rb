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
    Timeout::timeout(TIME_OUT) do
      resp = open(params['url']).read
      xml = Crack::XML.parse(resp)
      xml.to_json 
    end
  rescue Timeout::Error
    "({'error' : 'Requesting the json took too long. Time limit is #{TIME_OUT} seconds.'})"
  rescue Errno::ENOENT => e
    "({'error' : 'Problem requesting the json: #{e}'})"
  end
end