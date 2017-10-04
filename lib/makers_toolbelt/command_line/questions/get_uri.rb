require_relative './question'
require_relative '../../../makers_toolbelt'

module MakersToolbelt
  module CommandLine
    class GetURI < Question

      private

      def validate(input)
        return input if input.empty?
        raise "You must enter a valid uri e.g. https://example.com" unless valid_uri?(input)
        input
      end

      def valid_uri?(input)
        input =~ /\A#{URI::regexp(['http', 'https'])}\z/
      end
    end
  end
end
