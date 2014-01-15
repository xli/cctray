$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'test/unit'
require 'cctray'
require 'webrick'

class CCTrayTest < Test::Unit::TestCase
  include WEBrick

  def setup
    @dir = File.join(File.dirname(__FILE__), 'data')
    @server = HTTPServer.new(Port: '1234', DocumentRoot: @dir, Logger: WEBrick::Log.new("/dev/null"), AccessLog: [])
    Thread.start do
      @server.start
    end
  end

  def teardown
    @server.shutdown
  end

  def test_fetch
    cctray = CCTray.new("http://localhost:1234/cctray.xml")
    projects = cctray.fetch
    assert_equal 3, projects.size
    assert_equal ['Deployment :: Install', 'HelloWorld', 'SvnTest'], projects.map{|proj| proj.name}.sort
    message_project = projects.find{|proj| proj.name =~ /HelloWorld/}
    assert_equal 1, message_project.messages.size
    assert_equal 'Xiao <xli@thoughtworks.com>', message_project.messages.first.text
    assert_equal 'Breakers', message_project.messages.first.kind
  end

  def test_fetch_https_and_basic_auth
    # ENV["CCTRAY_HTTPS_TEST_FEED_URL"] =
    # ENV['CCTRAY_TEST_USER'] =
    # ENV['CCTRAY_TEST_PASS'] =

    if ENV['CCTRAY_TEST_USER']
      cctray = CCTray.new(ENV["CCTRAY_HTTPS_TEST_FEED_URL"],
                          ENV['CCTRAY_TEST_USER'],
                          ENV['CCTRAY_TEST_PASS'])
      assert cctray.fetch
    else
      warn "ignore test_fetch_https_and_basic_auth as no CCTRAY_TEST_USER setup"
    end
  end
end
