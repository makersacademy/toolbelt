Gem::Specification.new do |s|
  s.name = 'makers_toolbelt'
  s.version = '0.1.2'
  s.summary = 'Makers Academy command toolbelt'
  s.authors = ['Ben Forrest', 'Sam Joseph']
  s.files = [
    'lib/makers_toolbelt.rb',
    'command_map.yml',
    'lib/makers_toolbelt/fetch_pull_requests.rb',
    'lib/makers_toolbelt/generate_pairs.rb'
  ]
  s.add_runtime_dependency 'octokit'
  s.add_runtime_dependency 'one_factorization'
  s.executables << 'makers'
end
