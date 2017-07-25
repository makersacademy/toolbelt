require_relative './question'

module MakersToolbelt
  module CommandLine
    class GetPositiveNumber < Question

      def call
        super.to_i
      end

      private

      def validate(input)
        unless is_number?(input) && is_greater_than_zero?(input)
          raise "You must enter a valid number" 
        end
        input
      end

      def is_number?(input)
        input.to_i.to_s == input
      end

      def is_greater_than_zero?(input)
        input.to_i > 0
      end
    end
  end
end
