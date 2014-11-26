require 'faraday'
require 'faraday_middleware'
require 'json'
require 'jbuilder'

# POST /auth/github HTTP/1.1
# User-Agent: MyClient/1.0.0
# Accept: application/vnd.travis-ci.2+json
# Host: api.travis-ci.org
# Content-Type: application/json
# Content-Length: 37
c = Faraday.new do |c|
  c.use FaradayMiddleware::FollowRedirects
  c.adapter :httpclient
end
rsp = c.post("http://api.travis-ci.org/auth/github") do |rq|
  rq["User-Agent"] = "MyClient/1.0.0"
  rq["Accept"] = "application/vnd.travis-ci.2+json"
  rq["Content-Type"] = "application/json"
  rq["Content-Length"] = 37
  rq.body = Jbuilder.encode do |j|
    j.github_token "838154810932df53cd2eb9f17e406c04514c190a"
  end
end

r = JSON.parse(rsp.body)['access_token']
puts "r:#{r} ---- #{File.basename __FILE__}:#{__LINE__}"

# nJ7S5EPW0jVTJf24EygRaw
