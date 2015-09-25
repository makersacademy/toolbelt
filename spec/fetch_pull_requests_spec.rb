require './lib/fetch_pull_requests'

module MakersToolbelt

  describe FetchPullRequests do
    it 'returns the repo name from the origin remote' do
      expect(FetchPullRequests.repo).to eq 'makersacademy/toolbelt'
    end

    describe 'repo_from_remote_path' do
      it 'returns the repo from an SSH path ignoring leading spaces' do
        expect(FetchPullRequests.repo_from_remote_path('    git@github.com:makersacademy/toolbelt.git\n')).to eq 'makersacademy/toolbelt'
      end

      it 'returns the repo from an SSH Fetch URL ignoring leading spaces' do
        expect(FetchPullRequests.repo_from_remote_path('    Fetch URL: git@github.com:makersacademy/toolbelt.git\n')).to eq 'makersacademy/toolbelt'
      end

      it 'returns the repo from an HTTP path ignoring leading spaces' do
        expect(FetchPullRequests.repo_from_remote_path('    https://github.com/makersacademy/toolbelt.git\n')).to eq 'makersacademy/toolbelt'
      end

      it 'returns the repo from an HTTP Fetch URL ignoring leading spaces' do
        expect(FetchPullRequests.repo_from_remote_path('    Fetch URL: https://github.com/makersacademy/toolbelt.git\n')).to eq 'makersacademy/toolbelt'
      end
    end
  end

  describe 'include_open?' do
    it 'include_open? is true for open filters' do
      ['-a', '--all', '-o', '--open'].each do |filter|
        expect(FetchPullRequests.include_open?(filter)).to be true
      end
    end

    it 'include_open? is false for closed ilters' do
      ['-c', '--closed'].each do |filter|
        expect(FetchPullRequests.include_open?(filter)).to be false
      end
    end
  end

  describe 'include_closed?' do
    it 'include_closed? is false for open filters' do
      ['-o', '--open'].each do |filter|
        expect(FetchPullRequests.include_closed?(filter)).to be false
      end
    end

    it 'include_closed? is true for closed filters' do
      ['-a', '--all', '-c', '--closed'].each do |filter|
        expect(FetchPullRequests.include_closed?(filter)).to be true
      end
    end
  end
end
