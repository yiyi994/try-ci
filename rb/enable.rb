require 'faraday'
require 'faraday_middleware'
require 'json'
require 'jbuilder'

c = Faraday.new do |c|
  c.use FaradayMiddleware::FollowRedirects
  c.adapter :httpclient
end


r = c.get("http://api.travis-ci.org/hooks") do |rq|
  rq["User-Agent"] = "MyClient/1.0.0"
  rq["Accept"] = "application/vnd.travis-ci.2+json"
  rq["Authorization"] = "token nJ7S5EPW0jVTJf24EygRaw"
  rq["Content-Type"] = "application/json"
end.body

puts "r:#{r} ---- #{File.basename __FILE__}:#{__LINE__}"

# PUT /hooks HTTP/1.1
# User-Agent: MyClient/1.0.0
# Accept: application/vnd.travis-ci.2+json
# Authorization: token YOUR TRAVIS ACCESS TOKEN
# Host: api.travis-ci.org
# Content-Type: application/json
#
# {
#     "hook": {
#     "id": 42,
#     "active": true
# }
# }
r = c.put("http://api.travis-ci.org/hooks") do |rq|
  rq["User-Agent"] = "MyClient/1.0.0"
  rq["Accept"] = "application/vnd.travis-ci.2+json"
  rq["Authorization"] = "token nJ7S5EPW0jVTJf24EygRaw"
  rq["Content-Type"] = "application/json"

  rq.body = Jbuilder.encode do |j|
    j.id 3456587
    j.active true
  end
end.body

puts "r:#{r} ---- #{File.basename __FILE__}:#{__LINE__}"

# r:{"hooks":[{"id":3456587,"name":"try-ci","owner_name":"yiyi994","description":"","active":null,"private":false,"admin":true}]} ---- enable.rb:19
# r:{"error":"Travis encountered an error, sorry :("} ---- enable.rb:46
