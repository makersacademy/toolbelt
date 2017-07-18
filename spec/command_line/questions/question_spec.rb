require 'makers_toolbelt'
module MakersToolbelt

  RSpec.describe Question do

    subject(:cohort_id){ Question.new(instream: instream, outstream: outstream) }
    let(:instream){ double :instream }
    let(:outstream){ double :outstream, print: nil }

    before do
      any_number_string = "1"
      allow(instream).to receive(:gets).and_return(any_number_string)
    end

    it 'calls for the question' do
      cohort_id.call

      expect(outstream).to have_received(:print).with("Enter question: ")
    end

    it 'calls for input' do
      cohort_id.call

      expect(instream).to have_received(:gets).once
    end

    it "raises error if response can't be coerced into Integer" do
      allow(instream).to receive(:gets).and_return("z")

      expect{cohort_id.call}.to raise_error("You must enter a valid number")
    end

    it 'returns the question as a hash' do
      this_cohort_id = "1"
      allow(instream).to receive(:gets).and_return(this_cohort_id)

      expected_option = {question: this_cohort_id}

      expect(cohort_id.call).to eq(expected_option)
    end
  end
end
