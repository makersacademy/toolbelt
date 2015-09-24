require 'octokit'

client = Octokit::Client.new client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET']


origin = `git remote show origin | grep 'Fetch URL:'`
origin.gsub!(/\s*Fetch URL: (https:\/\/github\.com\/|git@github\.com:)/,'').gsub!(/\/\n|.git\n/, '')

pulls = client.pull_requests origin,  state: 'open',  per_page: 100
closed_pulls = client.pull_requests origin,  state: 'closed', per_page: 100
closed_pulls.concat client.last_response.rels[:next].get.data
pulls.concat closed_pulls

name_urls = pulls.map { |p| [p.head.repo.owner.login, p.head.repo.html_url] if p.head.repo }

name_urls.each do |name, url|
  `git remote add #{name} #{url}`
  `git fetch #{name}`
end
