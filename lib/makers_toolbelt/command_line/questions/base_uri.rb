require_relative 'question'

class BaseURI < Question

  private

  def question_text
    "Enter base uri (press enter for #{default_uri}): "
  end

  def question_name
    :base_uri
  end

  def default_uri
    HubClient::HUB_URL
  end
  
  def validate(input)
    return default_uri if input.empty?
    invalid_message = "You must enter a valid url e.g. https://example.com"
    raise invalid_message unless is_valid_uri?(input)
    input
  end

  def is_valid_uri?(input)
    input =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
