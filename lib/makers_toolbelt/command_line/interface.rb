require_relative 'questions/get_uri'
require_relative 'questions/get_positive_number'
require './lib/makers_toolbelt'

module MakersToolbelt
  module CommandLine
    class Interface

      attr_reader :answers
      private :answers

      def self.ask_questions(question_set)
        new.send(question_set)
      end

      def initialize
        @answers = {}
      end

      def randomize_bytes
        answers[:cohort_id] = GetPositiveNumber.call(question: "Enter cohort id: ")
        answers[:number_of_bytes] = GetPositiveNumber.call(question: "Enter required number of bytes: ")
        answers[:base_uri] = GetURI.call(question: "Enter base uri (press enter for #{HubClient::HUB_URL}): ")
        answers
      end
    end
  end
end
