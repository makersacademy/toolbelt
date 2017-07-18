require_relative 'hub_client'
require_relative 'command_line/interface'

module MakersToolbelt
  class RandomizeBytes

    attr_reader :client, :options
    private :client, :options

    DEFAULT_CLIENT = HubClient
    DEFAULT_OPTIONS = CommandLine::Interface

    def initialize(client: nil, options: nil)
      @options = options || DEFAULT_OPTIONS.randomize_bytes
      @client = client || DEFAULT_CLIENT.new
    end

    def run
      response = client.randomize_bytes(**options) 
      output(response)
    end

    private

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
end
