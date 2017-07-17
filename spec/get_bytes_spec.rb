require 'makers_toolbelt'

module MakersToolbelt

  RSpec.describe GetBytes do
    let(:hub_response) do
      {bytes: 
        [
          [
            {name: "Dan"},
            {name: "Mary"},
            {name: "Rachel"}
          ],
          [
            {name: "Roi"},
            {name: "Kay"},
            {name: "Sam"}
          ]
        ]
      }
    end

    let(:hub_client){ double :client }

    xit 'returns a list of names in bytes' do
      expected_bytes = <<-BYTES
Byte 0
======

Dan
Mary
Rachel

Byte 1
======

Roi
Kay
Sam

BYTES
      number_of_bytes = 2
      cohort_id = 2

      expect(RandomizeBytes.call(number_of_bytes: number_of_bytes, cohort_id: cohort_id, client: hub_client)).to eq expected_bytes
    end
  end
end
