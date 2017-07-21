require 'makers_toolbelt/command_line/questions/base_uri'

module MakersToolbelt

  RSpec.describe BaseURI do

    subject(:base_uri){ BaseURI.new(instream: instream, outstream: outstream) }
    let(:instream){ double :instream }
    let(:outstream){ double :outstream, print: nil }

    before do
      some_url = "http://some-url.com"
      allow(instream).to receive(:gets).and_return(some_url)
    end

    it 'asks for the base uri' do
      default_uri = HubClient::HUB_URL
      base_uri_question = "Enter base uri (press enter for #{default_uri}): "

      base_uri.call

      expect(outstream).to have_received(:print).with(base_uri_question)
    end

    it 'asks for input' do
      base_uri.call

      expect(instream).to have_received(:gets).once
    end

    it "raises error if response is not valid uri" do
      allow(instream).to receive(:gets).and_return("z")

      expect{base_uri.call}.to raise_error("You must enter a valid url e.g. https://example.com")
    end

    it "returns default uri if no uri is specified" do
      allow(instream).to receive(:gets).and_return("")

      expected_option = {base_uri: HubClient::HUB_URL}

      expect(base_uri.call).to eq(expected_option)
    end

    it "returns base uri as a hash" do
      requested_uri = "http://localhost:3000"
      allow(instream).to receive(:gets).and_return(requested_uri)

      expected_option = {base_uri: requested_uri}

      expect(base_uri.call).to eq(expected_option)
    end
  end
end
