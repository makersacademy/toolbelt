require 'httparty'
require 'json'

class HubClient
  include HTTParty

  attr_reader :auth_token
  private :auth_token

  HUB_URL = "https://hub.makersacademy.com"

  RANDOMIZE_BYTES_PATH = -> (cohort_id) do
    "/api/v1/cohorts/#{cohort_id}/randomize_bytes" 
  end

  format :json

  def initialize(auth_token: nil)
    @auth_token = auth_token || ENV['HUB_AUTH_TOKEN']
  end

  def randomize_bytes(cohort_id:, number_of_bytes:, base_uri: nil)
    uri = base_uri || HUB_URL
    query = {"number_of_bytes" => number_of_bytes, "auth_token" => auth_token}
    self.class.post(randomize_bytes_path(uri, cohort_id), query: query)
  end

  private

  def randomize_bytes_path(base_uri, cohort_id)
    base_uri + RANDOMIZE_BYTES_PATH.call(cohort_id)
  end

  def prettify(bytes, test)
    print output unless test
    output
  end
end
