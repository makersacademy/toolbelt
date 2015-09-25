require 'octokit'

module MakersToolbelt
  module FetchPullRequests
    OPEN_SWITCHES = ['-a', '--all', '-o', '--open']
    CLOSED_SWITCHES = ['-a', '--all', '-c', '--closed']

    class << self

      def call(options)
        filter = options['include'] || '--open'
        pulls = []
        pulls << open_pull_requests if include_open?(filter)
        pulls << closed_pull_requests if include_closed?(filter)

        pulls.flatten!.select! {|p| p.head.repo }

        puts pulls
        pulls.map { |p| [p.head.repo.owner.login, p.head.repo.html_url] }.each do |name, url|
          `git remote add #{name} #{url}`
          puts `git fetch #{name}`
        end
      end

      def repo
        @repo ||= repo_from_remote_path(origin_path)
      end

      def repo_from_remote_path(path)
        @regex ||= /\s*(?:Fetch URL: )?(?:https:\/\/|git@)github\.com(?::|\/)?(.*\/.*).git/
        @regex.match(path).captures.first
      end

      def include_open?(filter)
        OPEN_SWITCHES.include? filter
      end

      def include_closed?(filter)
        CLOSED_SWITCHES.include? filter
      end

      private

      def open_pull_requests
        client.pull_requests repo, state: 'open', per_page: 100
      end

      def closed_pull_requests
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
end
