Gem::Specification.new do |s|
  s.name = 'cctray'
  s.version = '0.0.1'
  s.summary = 'Small codebase to fetch cctray xml data from server and parse out as ruby objects'
  s.license = 'MIT'
  s.authors = ["Xiao Li"]
  s.email = ['swing1979@gmail.com']
  s.homepage = 'https://github.com/xli/cctray'

  s.add_dependency('nokogiri')

  s.add_development_dependency('rake')

  s.files = ['README.md']
  s.files += Dir['lib/**/*.rb']
end
