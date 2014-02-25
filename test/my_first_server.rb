require 'webrick'
require 'json'

server = WEBrick::HTTPServer.new :Port => 8080

trap('INT') { server.shutdown }

server.mount_proc '/' do |req, res|
  res.content_type = 'text/text'
  res.body = req.cookies.to_json
end

server.start