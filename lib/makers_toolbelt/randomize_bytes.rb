require_relative 'hub_client'
require_relative 'command_line_questions'

class RandomizeBytes

  attr_reader :number_of_bytes, :cohort_id, :client, :base_uri
  private :number_of_bytes, :cohort_id, :client, :base_uri
  
  DEFAULT_CLIENT = HubClient.new
  DEFAULT_OPTIONS = CommandLineQuestions

  def initialize(client: nil, options: nil)
    options ||= DEFAULT_OPTIONS.randomize_bytes
    @number_of_bytes = options[:number_of_bytes]
    @cohort_id = options[:cohort_id]
    @base_uri = options[:base_uri]
    @client = client || DEFAULT_CLIENT
    validate_input
  end

  def run
    response = client.randomize_bytes(cohort_id: cohort_id, number_of_bytes: number_of_bytes, base_uri: base_uri) 
    output(response)
  end

  private

  def validate_input
    raise ::BadRequest.new("Please provide cohort id") unless cohort_id
    raise ::BadRequest.new("Please provide number of bytes") unless number_of_bytes
  end

  def output(response)
    return successful_output(response) if response.success?
    unsuccessful_output(response)
  end

  def successful_output(response)
    bytes = JSON.parse(response.body)
    output = prettify(bytes)
    print output
  end

  def prettify(bytes)
    bytes.each_with_index.inject("") do |aggregate, (byte, byte_number)| 
      string = "#{aggregate}Byte #{byte_number}\n======\n\n"
      byte.each{|student| string << "#{student["name"]}\n"}
      string << "\n"
    end 
  end

  def unsuccessful_output(response)
    print "\n#{response.code_type} #{response.code} #{response.msg}\n"
  end

end

class BadRequest < StandardError ; end
