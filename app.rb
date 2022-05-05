require "socket"
require_relative "lib/message"
require_relative "lib/server"
require_relative "lib/request"

Server.start(9292)
