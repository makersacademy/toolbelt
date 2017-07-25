require 'json'
require 'makers_toolbelt'

module MakersToolbelt
  RSpec.describe RandomizeBytes do

    let(:hub_client){ double :hub_client, post: response }

    describe 'successful requests' do

      let(:response){ double :response, success?: true }
      let(:cohort_id) { 1 }
      let(:number_of_bytes) { 2 }
      let(:base_uri){ "http://localhost:3000" }
      let(:path){ RandomizeBytes::RANDOMIZE_BYTES_PATH.call(cohort_id)}
      let(:interface){ double :interface, ask_questions: options }
      let(:options){ {number_of_bytes: number_of_bytes, cohort_id: cohort_id, base_uri: base_uri} }

      subject(:randomize_bytes){ RandomizeBytes.new(interface: interface, client: hub_client) }

      it 'requests bytes from hub client' do
        allow(response).to receive(:body).and_return("[]")
        randomize_bytes.run
        expected_options = {
          path: path,
          params: { number_of_bytes: number_of_bytes },
          base_uri: base_uri,
        }
        expect(hub_client).to have_received(:post)
          .with(**expected_options)
      end

      it 'returns pretty bytes' do

        student_1 = {name: "student 1", byte: 0}
        student_2 = {name: "student 2", byte: 0}
        student_3 = {name: "student 3", byte: 0}
        student_4 = {name: "student 4", byte: 0}

        bytes_data = [
          [
            student_1,
            student_2
          ],
          [
            student_3,
            student_4
          ]
        ].to_json

        expected_output = <<-BYTES
Byte 0
======

#{student_1[:name]}
#{student_2[:name]}

Byte 1
======

#{student_3[:name]}
#{student_4[:name]}

BYTES

        allow(response).to receive(:body).and_return(bytes_data)
        expect{randomize_bytes.run}.to output(expected_output).to_stdout
      end

      context 'unsuccessful requests' do

        let(:response){ double :response, success?: false }

        it 'returns the status of the response' do

          unsuccessful_code = "500"
          unsuccessful_code_type = "Net::HTTP::InternalServerError"
          unsuccessful_msg = "Internal Server Error"

          allow(response).to receive(:code).and_return(unsuccessful_code)
          allow(response).to receive(:msg).and_return(unsuccessful_msg)
          allow(response).to receive(:code_type).and_return(unsuccessful_code_type)


          expected_output = "\n#{unsuccessful_code_type} #{unsuccessful_code} #{unsuccessful_msg}\n"

          expect{randomize_bytes.run}.to output(expected_output).to_stdout
        end
      end

    end
  end

end
