require 'makers_toolbelt/command_line/questions/number_of_bytes'

module MakersToolbelt
  RSpec.describe CohortID do

    subject(:cohort_id){ CohortID.new(instream: instream, outstream: outstream) }
    let(:instream){ double :instream }
    let(:outstream){ double :outstream, print: nil }

    before do
      any_number_string = "1"
      allow(instream).to receive(:gets).and_return(any_number_string)
    end

    it 'calls for the cohort id' do
      cohort_id.call

      expect(outstream).to have_received(:print).with("Enter cohort id: ")
    end

    it 'calls for input' do
      cohort_id.call

      expect(instream).to have_received(:gets).once
    end

    it "raises error if response can't be coerced into Integer" do
      allow(instream).to receive(:gets).and_return("z")

      expect{cohort_id.call}.to raise_error("You must enter a valid number")
    end

    it 'returns the cohort id as a hash' do
      this_cohort_id = 1
      allow(instream).to receive(:gets).and_return(this_cohort_id.to_s)

      expected_option = {cohort_id: this_cohort_id}

      expect(cohort_id.call).to eq(expected_option)
    end
  end
end
