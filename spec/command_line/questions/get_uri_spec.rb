require './lib/makers_toolbelt/command_line/questions/get_uri'

module MakersToolbelt
  module CommandLine
    RSpec.describe GetURI do

      let(:question){ "some question requiring a valid uri as a response" }
      let(:instream){ double :instream }
      let(:outstream){ double :outstream, print: nil }
      let(:options){ {question: question, instream: instream, outstream: outstream} }

      before do
        some_uri = "http://some-uri.com"
        allow(instream).to receive(:gets).and_return(some_uri)
      end

      it 'asks for the base uri' do
        GetURI.call(**options)

        expect(outstream).to have_received(:print).with(question)
      end

      it 'asks for input' do
        GetURI.call(**options)

        expect(instream).to have_received(:gets).once
      end

      it "raises error if response is not valid uri" do
        allow(instream).to receive(:gets).and_return("z")

        expect{GetURI.call(**options)}
          .to raise_error("You must enter a valid uri e.g. https://example.com")
      end

      it "returns empty string if no uri is specified" do
        allow(instream).to receive(:gets).and_return("")

        expected_option = ""

        expect(GetURI.call(**options)).to eq(expected_option)
      end

      it "returns base uri" do
        requested_uri = "http://localhost:3000"
        allow(instream).to receive(:gets).and_return(requested_uri)

        expected_option = requested_uri

        expect(GetURI.call(**options)).to eq(expected_option)
      end
    end
  end
end
