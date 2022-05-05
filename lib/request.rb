class Request
    attr_reader :req,
                :host,
                :connection,
                :cache,
                :sec_one,
                :sec_two,
                :sec_three,
                :upgrade,
                :user_agent,
                :accept,
                :sec_fetch_site,
                :sec_fecth_mode,
                :sec_fetch_user,
                :sec_fetch_dest,
                :accept_encoding,
                :accept_language,
                :sec_gpc,
                :lines,
                :count

    def initialize(lines)
        @req = lines[0]
        @host = lines[1]
        @connection = lines[2]
        @cache = lines[3]
        @sec_one = lines[4]
        @sec_two = lines[5]
        @sec_three = lines[6]
        @upgrade = lines[7]
        @user_agent = lines[8]
        @accept = lines[9]
        @sec_fetch_site = lines[10]
        @sec_fecth_mode = lines[11]
        @sec_fetch_user = lines[12]
        @sec_fetch_dest = lines[13]
        @accept_encoding = lines[14]
        @accept_language = lines[15]
        @sec_gpc = lines[16]
        @lines = lines
        @count = 0
    end

    def duplicate_request
        @count += 1
    end

    def verb
        @req.split(" ").first
    end

    def path
        @req.split(" ")[1]
    end

    def protocol
        @req.split(" ").last
    end

    class << self
        def create(client)
            request_lines = []
            while line = client.gets and !line.chomp.empty?
                request_lines << line.chomp
            end
            Request.new(request_lines)
        end
    end
end
