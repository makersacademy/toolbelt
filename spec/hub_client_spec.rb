require 'makers_toolbelt'
require 'webmock/rspec'
require 'json'

module MakersToolbelt
  RSpec.describe HubClient do

    TOKEN = "123456789009876543211234567890"

    subject(:hub_client){ HubClient.new(auth_token: TOKEN) }

    describe '#randomize_bytes' do

      it 'sends request to randomize bytes' do
        cohort_id = 1
        number_of_bytes = 2
        base_uri = "http://localhost:3000"
        params = {number_of_bytes: number_of_bytes, auth_token: TOKEN}

        randomize_bytes = stub_request(:post, request_url(cohort_id: cohort_id, base_uri: base_uri))
          .with(query: params)

        hub_client.randomize_bytes(number_of_bytes: number_of_bytes, cohort_id: cohort_id, base_uri: base_uri)

        expect(randomize_bytes).to have_been_requested
      end

      it 'sends request to default uri' do
        cohort_id = 1
        number_of_bytes = 2
        params = {number_of_bytes: number_of_bytes, auth_token: TOKEN}

        randomize_bytes = stub_request(:post, request_url(cohort_id: cohort_id))
          .with(query: params)

        hub_client.randomize_bytes(number_of_bytes: number_of_bytes, cohort_id: cohort_id)

        expect(randomize_bytes).to have_been_requested
      end

    end

    def request_url(cohort_id:, base_uri: nil)
      base_uri = base_uri || HubClient::HUB_URL
      path = HubClient::RANDOMIZE_BYTES_PATH.call(cohort_id)
      base_uri + path
    end

  end
end