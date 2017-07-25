require 'makers_toolbelt/command_line/questions/get_positive_number'

module MakersToolbelt
  module CommandLine
    RSpec.describe GetPositiveNumber do

      let(:question){ "some question requiring a positive number as a response" }
      let(:instream){ double :instream }
      let(:outstream){ double :outstream, print: nil }
      let(:options){ {question: question, instream: instream, outstream: outstream} }

      before do
        any_number_string = "1"
        allow(instream).to receive(:gets).and_return(any_number_string)
      end

      it 'calls for the cohort id' do
        GetPositiveNumber.call(**options)

        expect(outstream).to have_received(:print).with(question)
      end

      it 'calls for input' do
        GetPositiveNumber.call(**options)

        expect(instream).to have_received(:gets).once
      end

      it "raises error if response can't be coerced into Integer" do
        allow(instream).to receive(:gets).and_return("z")

        expect{GetPositiveNumber.call(**options)}
          .to raise_error("You must enter a valid number")
      end

      it 'returns the cohort id as an integer' do
        response = "1"
        allow(instream).to receive(:gets).and_return(response)

        expect(GetPositiveNumber.call(**options)).to eq(response.to_i)
      end
    end
  end
end
