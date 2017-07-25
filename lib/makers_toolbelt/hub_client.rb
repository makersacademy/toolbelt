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

  def post(path:, params:, base_uri: nil)
    query = params.merge({"auth_token" => auth_token})
    headers = {'Content-Type' => 'application/json' } 
    self.class.post(uri(base_uri, path), query: query, headers: headers)
  end

  private

  def uri(base_uri, path)
    if base_uri.nil? || base_uri.empty? 
      base_uri = HUB_URL
    end
    base_uri + path
  end

end
