require_relative "message"
require_relative "request"

class Server
    attr_reader :client

    def initialize(port)
        @port = port
        @client = TCPServer.new(@port)
    end

    class << self
        @@count = 0
        @@l = true

        def start(port)
            server = Server.new(port)
            while @@l == true do
                Thread.start(server.client.accept) do |client|
                    Message.ready
                    request = Request.create(client)
                    Message.transmit(request.lines)

                    route(request, client)
                end
            end
        end

        def route(request, client)
            if request.path == "/"
                response = Message.debug(request.lines)
                expose(client, response[:headers], response[:output])
            elsif request.path == "/hello"
                @@count += 1
                response = Message.hello(@@count)
                expose(client, response[:headers], response[:output])
            elsif request.path == "/datetime"
                response = Message.current_time
                expose(client, response[:headers], response[:output])
            elsif request.path == "/shutdown"
                response = Message.shutdown(@@count)
                expose(client, response[:headers], response[:output])
                client.close
                @@l = false
            end
        end

        def expose(client, headers, output)
            client.puts headers
            client.puts output
            Message.response_lines(headers, output)
            Message.complete
        end
    end
end
