require 'rubygems'
require 'sinatra'
require 'httparty'

get '/' do
  if params['url']
    response = HTTParty.get(params['url'])
    "#{params['callback']}(#{response.body.to_json})" 
  else
    "<h1>XML2JSONP API Proxy</h1><code>required params['url'] and params['callback']</code><p><a href='http://github.com/bitzesty/xml2jsonp'>http://github.com/bitzesty/xml2jsonp</a> by <a href='http://bitzesty.com'>Bit Zesty - a Ruby on Rails development company</a></p>"
  end
end

post '/' do
  url = params.delete('url')
  callback = params.delete('callback')
  response = HTTParty.post(url, params)
  "#{params['callback']}(#{response.body.to_json})"
end

put '/' do
  url = params.delete('url')
  callback = params.delete('callback')
  response = HTTParty.put(url, params)
  "#{params['callback']}(#{response.body.to_json})"
end

delete '/' do
  url = params.delete('url')
  callback = params.delete('callback')
  response = HTTParty.delete(url, params)
  "#{params['callback']}(#{response.body.to_json})"
end


