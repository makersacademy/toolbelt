require 'octokit'

module MakersToolbelt
  class FetchPullRequests
    OPEN_SWITCHES = ['-a', '--all', '-o', '--open']
    CLOSED_SWITCHES = ['-a', '--all', '-c', '--closed']

    attr_reader :options, :filter

    def initialize(options = {})
      @options = options
      @filter = options[:filter] || '--open'
    end

    def run()
      pulls = []
      pulls << open_pull_requests if include_open?
      pulls << closed_pull_requests if include_closed?

      pulls.flatten!.select! {|p| p.head.repo }

      puts pulls
      pulls.map { |p| [p.head.repo.owner.login, p.head.repo.html_url] }.each do |name, url|
        puts "adding #{name}"
        `git remote add #{name} #{url}`
        puts "fetching #{url}"
        `git fetch #{name}`
      end
    end

    def repo
      @repo ||= repo_from_remote_path(origin_path)
    end

    def repo_from_remote_path(path)
      @regex ||= /\s*(?:Fetch URL: )?(?:https:\/\/|git@)github\.com(?::|\/)?(.*\/.*).git/
      @regex.match(path).captures.first
    end

    def include_open?
      OPEN_SWITCHES.include? filter
    end

    def include_closed?
      CLOSED_SWITCHES.include? filter
    end

    private

    def open_pull_requests
      puts "fetching open pull requests from #{repo}..."
      client.pull_requests repo, state: 'open', per_page: 100
    end

    def closed_pull_requests
      puts "fetching closed pull requests from #{repo}..."
      pulls = client.pull_requests repo, state: 'closed', per_page: 100
      pulls.concat client.last_response.rels[:next].get.data
    end

    def origin_path
      @origin_path ||= `git remote show origin | grep 'Fetch URL:'`
    end

    def client
      @client ||= Octokit::Client.new client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET']
    end
  end

end
