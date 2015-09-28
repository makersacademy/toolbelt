require 'octokit'

module MakersToolbelt
  class FetchPullRequests
    OPEN_SWITCHES = ['-a', '--all', '-o', '--open']
    CLOSED_SWITCHES = ['-a', '--all', '-c', '--closed']

    GITHUB_REMOTE_REGEX = /github\.com(?::|\/)?(.+\/[\w\-]+)(?:\.git|\/)?\n/

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
      @regex ||= GITHUB_REMOTE_REGEX
      @regex.match(path).captures.first
    rescue
      fail NotFoundError.new('Could not find remote origin')
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
      fetch_pull_requests('open')
    end

    def closed_pull_requests
      puts "fetching closed pull requests from #{repo}..."
      fetch_pull_requests('closed')
    end

    def fetch_pull_requests(state)
      pulls = client.pull_requests repo, state: state, per_page: 100
      fetch_more_pages(pulls)
    rescue StandardError => e
      puts "Error occurred while fetching pull requests: #{e.message}"
    ensure
      pulls
    end

    def fetch_more_pages(into_array)
      while response = client.last_response.rels[:next] do
        into_array << response.get.data
      end
      into_array
    end

    def origin_path
      @origin_path ||= `git remote show origin | grep 'Fetch URL:'`
    end

    def client
      @client ||= Octokit::Client.new client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET']
    end
  end

end
