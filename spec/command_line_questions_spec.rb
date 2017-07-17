require 'makers_toolbelt'

module MakersToolbelt
  RSpec.describe CommandLineQuestions do

    it "returns correct options to randomize bytes" do
      cohort_id = 1
      number_of_bytes = 2
      base_uri = 'https://hub.makersacademy.com'

      allow(STDIN).to receive(:gets).and_return(cohort_id.to_s, number_of_bytes.to_s, base_uri)
      allow($stdout).to receive(:print)

      expected_options = {
        cohort_id:       cohort_id,
        number_of_bytes: number_of_bytes,
        base_uri:        base_uri
      }

      expect(CommandLineQuestions.randomize_bytes).to eq(expected_options)
    end

    describe '#ask_questions' do

      subject(:cli){ CommandLineQuestions.new(outstream: outstream, instream: instream)}

      let(:outstream){ double :outstream, puts: nil, print: nil }
      let(:instream){ double :instream, gets: "" }

      describe '#cohort_id' do

        before do
          any_number_string = "1"
          allow(instream).to receive(:gets).and_return(any_number_string)
        end

        it 'asks for the cohort id' do
          cli.ask_questions(:cohort_id)

          expect(outstream).to have_received(:print).with("Enter cohort id: ")
        end

        it 'asks for input' do
          cli.ask_questions(:cohort_id)
          
          expect(instream).to have_received(:gets).once
        end

        it "raises error if response can't be coerced into Integer" do
          allow(instream).to receive(:gets).and_return("z")

          expect{cli.ask_questions(:cohort_id)}.to raise_error("You must enter a valid number")
        end

        it 'returns the cohort id as a hash' do
          cohort_id = 1
          allow(instream).to receive(:gets).and_return(cohort_id.to_s)

          expected_option = {cohort_id: cohort_id}

          expect(cli.ask_questions(:cohort_id)).to eq(expected_option)
        end
      end

      describe "#number_of_bytes" do

        before do
          any_number_string = "1"
          allow(instream).to receive(:gets).and_return(any_number_string)
        end

        it 'asks for the number of bytes' do
          cli.ask_questions(:number_of_bytes)

          expect(outstream).to have_received(:print).with("Enter number of bytes: ")
        end

        it 'asks for input' do
          cli.ask_questions(:number_of_bytes)
          
          expect(instream).to have_received(:gets).once
        end

        it "raises error if response can't be coerced into Integer" do
          allow(instream).to receive(:gets).and_return("z")

          expect{cli.ask_questions(:number_of_bytes)}.to raise_error("You must enter a valid number")
        end

        it 'returns the number of bytes as a hash' do
          number_of_bytes = 1
          allow(instream).to receive(:gets).and_return(number_of_bytes.to_s)

          expected_option = {number_of_bytes: number_of_bytes}

          expect(cli.ask_questions(:number_of_bytes)).to eq(expected_option)
        end
      end

      describe "#base_uri" do
        before do
          some_url = "http://some-url.com"
          allow(instream).to receive(:gets).and_return(some_url)
        end

        it 'asks for the base uri' do
          default_uri = CommandLineQuestions::HUB_URI
          base_uri_question = "Enter base uri (press enter for #{default_uri}): "

          cli.ask_questions(:base_uri)

          expect(outstream).to have_received(:print).with(base_uri_question)
        end

        it 'asks for input' do
          cli.ask_questions(:base_uri)
          
          expect(instream).to have_received(:gets).once
        end

        it "raises error if response is not valid uri" do
          allow(instream).to receive(:gets).and_return("z")

          expect{cli.ask_questions(:base_uri)}.to raise_error("You must enter a valid url e.g. https://example.com")
        end

        it "returns default uri if no ur is specified" do
          allow(instream).to receive(:gets).and_return("")

          expected_option = {base_uri: CommandLineQuestions::HUB_URI}

          expect(cli.ask_questions(:base_uri)).to eq(expected_option)
        end
      end
    end
  end
end
