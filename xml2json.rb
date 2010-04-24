require 'rubygems'
require 'sinatra'
require 'crack'
require 'json'
require 'open-uri'

get '/' do
  if params['url']
    resp = open(params['url']).read
    xml = Crack::XML.parse(resp)
    "#{params['callback']}(#{xml.to_json})" 
  else
    "<h1>XML2JSONP API Proxy</h1><code>required params['url'] and params['callback']</code><p><a href='http://github.com/bitzesty/xml2jsonp'>http://github.com/bitzesty/xml2jsonp</a></p>"
  end
end
