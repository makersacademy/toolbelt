require 'httparty'
require 'json'

class HubClient
  include HTTParty

  attr_reader :auth_token
  private :auth_token

  HUB_URL = "https://hub.makersacademy.com"

  format :json

  def initialize(auth_token: nil)
    @auth_token = auth_token || ENV['HUB_AUTH_TOKEN']
  end

  def randomize_bytes(path:, number_of_bytes:, base_uri: nil)
    uri = base_uri || HUB_URL
    query = {"number_of_bytes" => number_of_bytes, "auth_token" => auth_token}
    self.class.post(randomize_bytes_path(uri, path), query: query)
  end

  private

  def randomize_bytes_path(base_uri, path)
    base_uri + path
  end
end
