require 'makers_toolbelt'
module MakersToolbelt

  RSpec.describe Question do

    subject(:question){ Question.new(instream: instream, outstream: outstream) }
    let(:instream){ double :instream, gets: "" }
    let(:outstream){ double :outstream, print: nil }

    it 'raises not implemented errors' do
      expect{question.call}.to raise_error("Not Implemented: question_text")
      def question.question_text ; end
      expect{question.call}.to raise_error("Not Implemented: validate")
      def question.validate(_) ; end
      expect{question.call}.to raise_error("Not Implemented: question_name")
    end

  end
end
