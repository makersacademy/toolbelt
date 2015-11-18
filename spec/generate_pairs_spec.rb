require './lib/makers_toolbelt'

module MakersToolbelt
  READ_PATH = './spec/fixtures/generate_pairs/good'
  WRITE_PATH = './spec/fixtures/generate_pairs/good.pairs'

  describe GeneratePairs do
    let(:source) { READ_PATH }
    subject { GeneratePairs.new(source: source) }

    before do
      File.delete(WRITE_PATH) if File.exist?(WRITE_PATH)
    end

    it 'creates a local file suffixed .pairs' do
      subject.run
      expect(File).to exist(WRITE_PATH)
    end

    it 'derives a path from the given source' do
      expect(subject.path).to eq './spec/fixtures/generate_pairs/good.pairs'
    end
  end
end
