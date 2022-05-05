class Message
    class << self
        def ready
            puts "Ready for a request"
        end

        def transmit(request)
            puts "Got this request:"
            puts request.inspect
            puts "Sending response."
        end

        def complete
            puts "\nResponse complete, exiting."
        end

        def response_lines(headers, output)
            puts ["Wrote this response:", headers, output].join("\n")
        end

        def debug(request_lines)
            response = "<pre>" + request_lines.join("\n") + "</pre>"
            output = "<html><head></head><body>#{response}</body></html>"
            {
                headers: [
                    "http/1.1 200 ok",
                    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                    "server: ruby",
                    "content-type: text/html; charset=iso-8859-1",
                    "content-length: #{output.length}\r\n\r\n"
                ].join("\r\n"),
                output: output
            }
        end

        def hello(count)
            response = "<pre>" + "Hello, World! #{count}" + "</pre>"
            output = "<html><head></head><body>#{response}</body></html>"
            {
                headers: [
                    "http/1.1 200 ok",
                    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                    "server: ruby",
                    "content-type: text/html; charset=iso-8859-1",
                    "content-length: #{output.length}\r\n\r\n"
                ].join("\r\n"),
                output: output
            }
        end

        def current_time
            response = "<pre>" + "#{Time.now.strftime('%a, %e %b %Y %H')}" + "</pre>"
            output = "<html><head></head><body>#{response}</body></html>"
            {
                headers: [
                    "http/1.1 200 ok",
                    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                    "server: ruby",
                    "content-type: text/html; charset=iso-8859-1",
                    "content-length: #{output.length}\r\n\r\n"
                ].join("\r\n"),
                output: output
            }
        end

        def shutdown(count)
            response = "<pre>" + "Total Requests: #{count}" + "</pre>"
            output = "<html><head></head><body>#{response}</body></html>"
            {
                headers: [
                    "http/1.1 200 ok",
                    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                    "server: ruby",
                    "content-type: text/html; charset=iso-8859-1",
                    "content-length: #{output.length}\r\n\r\n"
                ].join("\r\n"),
                output: output
            }
        end
    end
end
