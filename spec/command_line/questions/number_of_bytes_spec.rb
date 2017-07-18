require 'makers_toolbelt/command_line/questions/number_of_bytes'

module MakersToolbelt

  RSpec.describe NumberOfBytes do
    subject(:number_of_bytes){ NumberOfBytes.new(instream: instream, outstream: outstream) }
    let(:instream){ double :instream }
    let(:outstream){ double :outstream, print: nil }

    before do
      any_number_string = "1"
      allow(instream).to receive(:gets).and_return(any_number_string)
    end

    it 'asks for the number of bytes' do
      number_of_bytes.call

      expect(outstream).to have_received(:print).with("Enter number of bytes: ")
    end

    it 'asks for input' do
      number_of_bytes.call

      expect(instream).to have_received(:gets).once
    end

    it "raises error if response can't be coerced into Integer" do
      allow(instream).to receive(:gets).and_return("z")

      expect{number_of_bytes.call}.to raise_error("You must enter a valid number")
    end

    it 'returns the number of bytes as a hash' do
      this_number_of_bytes = 1
      allow(instream).to receive(:gets).and_return(this_number_of_bytes.to_s)

      expected_option = {number_of_bytes: this_number_of_bytes}

      expect(number_of_bytes.call).to eq(expected_option)
    end
  end
end
