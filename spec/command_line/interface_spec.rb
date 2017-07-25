require 'makers_toolbelt'

module MakersToolbelt
  module CommandLine
    RSpec.describe Interface do

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

        expect(described_class.ask_questions(:randomize_bytes)).to eq(expected_options)
      end

    end
  end
end
