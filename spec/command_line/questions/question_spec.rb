require 'makers_toolbelt'
module MakersToolbelt

  module CommandLine
    RSpec.describe Question do

      let(:question){ "some string" }
      let(:instream){ double :instream, gets: "" }
      let(:outstream){ double :outstream, print: nil }

      it 'raises not implemented errors' do
        options = {question: question, instream: instream, outstream: outstream}

        expect{Question.call(**options)}.to raise_error("Not Implemented: validate")
      end

    end
  end
end
