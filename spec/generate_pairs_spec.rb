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

    describe '.run' do
      it 'contains a JSON formatted one-factorization of the names in the file' do
        names = GeneratePairs.load_names(READ_PATH)

        names_double = double(one_factorize: double(shuffle: names.one_factorize), count: names.count)
        allow(GeneratePairs).to receive(:load_names).and_return(names_double)
        expected = names.one_factorize
        subject.run
        result = JSON.parse(File.read(RESULT_PATH))
        expect(result).to eq expected
      end

      context 'for an odd number of names' do
        let(:names) { GeneratePairs.load_names(READ_PATH)[0..-2] } # Make it odd

        before(:each) do
          expect(names.count).to be_odd
          allow(GeneratePairs).to receive(:load_names).and_return(names)
        end

        it 'adds a member \'flying solo\' to pair the lone member with' do
          subject.run

          result = JSON.parse(File.read(RESULT_PATH))
          
          names.each do |name|
            next if name == 'Flying solo'
  
            possible_solo_pairings_for_name = [[name, 'Flying solo'], ['Flying solo', name]]
  
            # Check flying solo is always included
            result.each do |pairings|
              flattened_pairings = pairings.flatten
              expect(flattened_pairings).to(include('Flying solo'))
            end
  
            
            # Check 'flying solo' gets paired with everyone
            # Sort both so that order of two names is irrelevant
            all_possible_pairings = result.flatten(1).map(&:sort)
            original_names = names - ['Flying solo']
            original_names.each do |name|
              sorted_expected_pairing = [name, 'Flying solo'].sort
              expect(all_possible_pairings).to include(sorted_expected_pairing)
            end
          end
        end

        it 'works with an odd number of names' do
          expect {
            subject.run
          }.to_not(raise_error)
        end
      end
    end
  end
end
