module MakersToolbelt
  module CommandLine
    class Question
      attr_reader :question, :instream, :outstream
      private :question, :instream, :outstream

      def self.call(question:, instream: $stdin, outstream: $stdout)
        new(question, instream, outstream).call
      end

      def initialize(question, instream, outstream)
        @question = question
        @instream = instream
        @outstream = outstream
      end

      def call
        outstream.print(question)
        validate(instream.gets.chomp)
      end

      private

      def validate(input)
        raise "Not Implemented: #{__method__}"
      end
    end
  end
end
