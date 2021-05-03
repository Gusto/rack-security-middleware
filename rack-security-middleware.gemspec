Gem::Specification.new do |s|
  s.name = 'rack-security-middleware'
  s.version = RackSecurityMiddleware::VERSION

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Gusto Open Source']
  s.date = '2021-01-06'
  s.description = 'Middleware collection to secure a Rack application'
  s.email = 'open-source@gusto.com'
  s.extra_rdoc_files = %w(README)

  s.files = Dir[File.join('lib', '**', '*')]
  s.test_files = Dir[File.join('spec', '**', '*')]

  s.homepage = 'https://github.com/Gusto/rack-security-middleware'
  s.require_paths = ['lib']
  s.summary = 'Middleware collection to secure a Rack application'

  s.add_development_dependency 'actionpack', '~> 5.2'
  s.add_development_dependency 'activesupport', '~> 5.2'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rack-test', "~> 1.0"
  s.add_development_dependency 'rake', "~> 12.3"
  s.add_development_dependency 'rspec', '~> 3.1.0'
end
