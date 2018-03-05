#URL Parser Class File

# I commented in my "work-in-progress" solutions to isolating information that didn't quite "work"

class UrlParser 
    attr_reader :scheme, :domain, :path, :fragment_id

    def initialize(site)
        @site = site
        @scheme = @site.split(":").at(0)
        @domain = @site.split(":")[1].tr("//", "")
        @path = @site.gsub("?", "/").split("/").at(3)
        @querystring = {}
        if @site.split('/')[2].include? ':' 
            @port = @site.gsub(":", "/").split("/").at(4)
        else 
            @port = nil 
        end
    end

    def port 
        if scheme == "https" && (@port == "" || @port == nil)
            @port = 443.to_s
        elsif scheme == "http" && (@port == "" || @port == nil)
            @port = 80.to_s
        end 
        @port
    end

    def path 
        if @path == "" 
            @path = nil
        end 
        @path
    end
   
    def query_string
#       @site.gsub("?", "/")sub_question.gsub("#", "/").split("/").at(4)
        query = @site.split('/')[3].split('?')[1].split('#')[0].split('&')
        query.each do |item|
            equal_split = item.split('=')
            @querystring[equal_split[0]] = equal_split[1]
        end 
        @querystring
    end

    def fragment_id
#       @site.gsub("#", "/").split("/").at(4)
        @fragment_id = @site.split('/')[3].split('?')[1].split('#')[1]
    end
end