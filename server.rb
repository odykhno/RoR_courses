require 'webrick'
require './controllers/index_controller'

server = WEBrick::HTTPServer.new :Port => 3000

server.mount_proc '/' do |req, res|
  res.content_type = 'text/html'

  IndexController.new(res).countries
end

server.start