Gem::Specification.new do |s|
  s.name = 'makers_toolbelt'
  s.version = '0.0.5'
  s.summary = 'Makers Academy command toolbelt'
  s.authors = ['Ben Forrest', 'Sam Joseph']
  s.files = [
    'lib/makers_toolbelt.rb',
    'command_map.yml',
    'lib/makers_toolbelt/fetch_pull_requests.rb'
  ]
  s.executables << 'makers'
end
