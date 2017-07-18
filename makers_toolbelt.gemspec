lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |s|
  s.name = 'makers_toolbelt'
  s.version = MakersToolBelt::VERSION
  s.summary = 'Makers Academy command toolbelt'
  s.description = 'Makers Academy command toolbelt'
  s.homepage = 'http://www.makersacademy.com'
  s.authors = ['Ben Forrest', 'Sam Joseph', 'Daniel Le Dosquet-Bergquist']
  s.email = ['dan@makersacademy.com']
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'octokit'
  s.add_runtime_dependency 'one_factorization'
  s.add_runtime_dependency 'commander'
  s.add_runtime_dependency 'httparty'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.executables << 'makers'
end
