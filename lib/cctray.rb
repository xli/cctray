require 'net/http'
require 'net/https'
require 'nokogiri'

class CCTray

  class Project < Struct.new(:name,
                             :activity,
                             :last_build_status,
                             :last_build_label,
                             :last_build_time,
                             :web_url,
                             :messages)
  end
  class Message < Struct.new(:kind, :text)
  end

  def initialize(feed_url, user=nil, pass=nil)
    @feed_url = feed_url
    @user, @pass = user, pass
  end

  def fetch
    Nokogiri::XML(get).css("Project").map do |proj|
      Project.new(proj[:name],
                  proj[:activity],
                  proj[:lastBuildStatus],
                  proj[:lastBuildLabel],
                  proj[:lastBuildTime],
                  proj[:webUrl],
                  proj.css('message').map{|m| Message.new(m[:kind], m[:text])})
    end
  end

  def get
    uri = URI(@feed_url)
    http_opts = { use_ssl: uri.scheme == 'https' }
    Net::HTTP.start uri.host, uri.port, http_opts do |https|
      req = Net::HTTP::Get.new(uri.path).tap do |req|
        req.basic_auth @user, @pass if @user
      end

      case res = https.request(req)
      when Net::HTTPSuccess
        res.body
      else
        res.error!
      end
    end
  end
end
