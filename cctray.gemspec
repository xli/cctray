Gem::Specification.new do |s|
  s.name = 'cctray'
  s.version = '0.0.1'
  s.summary = 'Simply fetch and parse cctray feed xml.'
  s.description = 'A simple CCTray class to fetch and parse the feed xml as ruby objects'
  s.license = 'MIT'
  s.authors = ["Xiao Li"]
  s.email = ['swing1979@gmail.com']
  s.homepage = 'https://github.com/xli/cctray'

  s.add_runtime_dependency('nokogiri', '~> 1.6', '>= 1.6.0')

  s.files = ['README.md']
  s.files += Dir['lib/**/*.rb']
end
