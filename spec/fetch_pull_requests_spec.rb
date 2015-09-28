require './lib/makers_toolbelt'

module MakersToolbelt

  describe FetchPullRequests do
    before do
      allow(subject).to receive('origin_path').and_return "  Fetch URL: git@github.com:makersacademy/toolbelt.git\n"
    end

    it 'returns the repo name from the origin remote' do
      expect(subject.repo).to eq 'makersacademy/toolbelt'
    end

    it 'fails when the origin remote cannot be found' do
      expect{subject.repo_from_remote_path('xxx')}.to raise_error NotFoundError
    end

    describe 'repo_from_remote_path' do
      it 'returns the repo from an SSH path ignoring leading spaces' do
        expect(subject.repo_from_remote_path("    git@github.com:makersacademy/toolbelt.git\n")).to eq 'makersacademy/toolbelt'
      end

      it 'returns the repo from an SSH Fetch URL ignoring leading spaces' do
        expect(subject.repo_from_remote_path("    Fetch URL: git@github.com:makersacademy/toolbelt.git\n")).to eq 'makersacademy/toolbelt'
      end

      it 'returns the repo from an HTTP path' do
        expect(subject.repo_from_remote_path("http://github.com/makersacademy/toolbelt\n")).to eq 'makersacademy/toolbelt'
      end

      it 'returns the repo from an HTTP Fetch URL ignoring leading spaces' do
        expect(subject.repo_from_remote_path("  Fetch URL: http://github.com/makersacademy/bowling-challenge/\n")).to eq 'makersacademy/bowling-challenge'
      end

      it 'returns the repo from an HTTPS path ignoring leading spaces' do
        expect(subject.repo_from_remote_path("    https://github.com/makersacademy/toolbelt.git\n")).to eq 'makersacademy/toolbelt'
      end

      it 'returns the repo from an HTTPS Fetch URL ignoring leading spaces' do
        expect(subject.repo_from_remote_path("    Fetch URL: https://github.com/makersacademy/toolbelt.git\n")).to eq 'makersacademy/toolbelt'
      end
    end
  end

  describe 'include_open?' do
    it 'is true for open filters' do
      ['-a', '--all', '-o', '--open'].each do |filter|
        expect(FetchPullRequests.new({filter: filter}).include_open?).to be true
      end
    end

    it 'is false for closed filters' do
      ['-c', '--closed'].each do |filter|
        expect(FetchPullRequests.new({filter: filter}).include_open?).to be false
      end
    end
  end

  describe 'include_closed?' do
    it 'is false for open filters' do
      ['-o', '--open'].each do |filter|
        expect(FetchPullRequests.new({filter: filter}).include_closed?).to be false
      end
    end

    it 'is true for closed filters' do
      ['-a', '--all', '-c', '--closed'].each do |filter|
        expect(FetchPullRequests.new({filter: filter}).include_closed?).to be true
      end
    end
  end
end
