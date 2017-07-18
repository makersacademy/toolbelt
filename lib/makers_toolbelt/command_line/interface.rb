require_relative 'questions/cohort_id'
require_relative 'questions/number_of_bytes'
require_relative 'questions/base_uri'

module MakersToolbelt
  module CommandLine
    class Interface

      attr_reader :answers, :outstream, :instream
      private :answers, :outstream, :instream

      HUB_URI = 'https://hub.makersacademy.com'
      RANDOMIZE_BYTES_QUESTIONS = [CohortID, NumberOfBytes, BaseURI]

      def self.randomize_bytes
        new.ask_questions(*RANDOMIZE_BYTES_QUESTIONS)
      end

      def initialize
        @answers = {}
      end

      def ask_questions(*questions)
        questions.each{ |question| answers.merge!(question.call) }
        answers
      end
    end
  end
end
