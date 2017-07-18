require_relative 'question'

class BaseURI < Question

  def call
    outstream.print "Enter base uri (press enter for #{HubClient::HUB_URL}): "
    response = instream.gets.chomp
    return {type => HubClient::HUB_URL} if response.empty?
    { type => validate(response) }
  end

  private

  def validate(input)
    invalid_message = "You must enter a valid url e.g. https://example.com"
    raise invalid_message unless is_valid?(input)
    input
  end

  def is_valid?(input)
    input =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
