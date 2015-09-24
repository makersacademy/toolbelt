require 'octokit'

client = Octokit::Client.new \
  client_id: ENV['GITHUB_CLIENT_ID'],
  client_secret: ENV['GITHUB_CLIENT_SECRET']

pulls = client.pull_requests 'makersacademy/takeaway-challenge',  state: 'open',  per_page: 100
pulls = client.pull_requests 'makersacademy/rps-challenge',  state: 'closed',  per_page: 100
pulls = client.pull_requests 'makersacademy/inject-challenge',  state: 'open',  per_page: 100
pulls = client.pull_requests 'makersacademy/airport_challenge',  per_page: 100
pulls = client.pull_requests 'makersacademy/till_tech_test',  per_page: 100
c_pulls = client.pull_requests 'makersacademy/till_tech_test',  state: 'closed', per_page: 100
c_pulls.concat client.last_response.rels[:next].get.data
pulls.concat c_pulls

name_urls = pulls.map { |p| [p.head.repo.owner.login, p.head.repo.html_url] if p.head.repo }

name_urls.each do |name, url|

  `git remote add #{name} #{url}`
  `git fetch #{name}`

end

# loop through each name
# do we grab and process `git remote`? I guess, to
# decouple for changes to reek and rubocop files ...

remotes = `git remote`.split
rubocop_outputs = remotes.map do |remote|
  `git reset --merge`
  `git checkout #{remote}/master`  # handling other branches?
  `git merge origin/master`  # handling other branches?
  `rubocop --format simple`
end
  pronto_output = `pronto run`
  `reek | wc -l`
  `rubocop | wc -l`
  # would like test pass fail ...
  # would like test coverage ...

# would like analysis of distribution of different kinds of offences/smells