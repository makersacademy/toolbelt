require_relative 'hub_client'
require_relative 'command_line/interface'

module MakersToolbelt
  class RandomizeBytes

    attr_reader :client, :interface
    private :client, :interface

    RANDOMIZE_BYTES_PATH = -> (cohort_id) do
      "/api/v1/cohorts/#{cohort_id}/randomize_bytes" 
    end

    def initialize(client: nil, interface: nil)
      @interface = interface || CommandLine::Interface
      @client = client || HubClient.new
    end

    def run
      @options = interface.ask_questions(:randomize_bytes)
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

    def options
      {
        path: RANDOMIZE_BYTES_PATH.call(@options[:cohort_id]),
        number_of_bytes: @options[:number_of_bytes],
        base_uri: @options[:base_uri]
      }
    end
  end
end
