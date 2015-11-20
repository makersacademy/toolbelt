require './lib/makers_toolbelt'

module MakersToolbelt
  READ_PATH = './spec/fixtures/generate_pairs/good'
  RESULT_PATH = './spec/fixtures/generate_pairs/good.pairs'

  describe GeneratePairs do
    let(:source) { READ_PATH }
    subject { GeneratePairs.new({source: source}) }

    before(:all) do
      File.delete(RESULT_PATH) if File.exist?(RESULT_PATH)
    end

    after do
      File.delete(RESULT_PATH) if File.exist?(RESULT_PATH)
    end

    describe '#load_names' do
      it 'returns an array of names loaded from the given file' do
        names = [
          'Ben',
          'Sam',
          'Roi',
          'Tansaku',
          'Steve',
          'Ptolemy',
          'Stefan',
          'Leo',
          'Spike',
          'Irina'
        ]
        expect(GeneratePairs.load_names(READ_PATH)).to eq names
      end
    end

    it 'creates a local file suffixed .pairs' do
      subject.run
      expect(File).to exist(RESULT_PATH)
    end

    it 'derives a path from the given source' do
      expect(subject.path).to eq './spec/fixtures/generate_pairs/good.pairs'
    end

    describe 'result' do
      it 'contains a JSON formatted one-factorization of the names in the file' do
        names = GeneratePairs.load_names(READ_PATH)
        expected = names.one_factorize
        subject.run
        result = JSON.parse(File.read(RESULT_PATH))
        expect(result).to eq expected
      end
    end

  end
end
