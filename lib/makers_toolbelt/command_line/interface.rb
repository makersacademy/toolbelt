require_relative 'questions/cohort_id'
require_relative 'questions/number_of_bytes'
require_relative 'questions/base_uri'

module MakersToolbelt
  module CommandLine
    class Interface

      attr_reader :answers
      private :answers

      RANDOMIZE_BYTES_QUESTIONS = [CohortID, NumberOfBytes, BaseURI]

      def self.ask_questions(question_set)
        new.send(question_set)
      end

      def initialize
        @answers = {}
      end

      def randomize_bytes
        RANDOMIZE_BYTES_QUESTIONS.each{ |question| answers.merge!(question.call) }
        answers
      end
    end
  end
end
