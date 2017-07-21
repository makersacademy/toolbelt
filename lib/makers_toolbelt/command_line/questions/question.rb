class Question
  attr_reader :type, :instream, :outstream
  private :type, :instream, :outstream

  def self.call
    new.call
  end

  def initialize(instream: $stdin, outstream: $stdout)
    @instream = instream
    @outstream = outstream
  end

  def call
    outstream.print(question_text)
    input = validate(instream.gets.chomp)
    {question_name => input}
  end

  private

  def question_text
    raise "Not Implemented: #{__method__}"
  end

  def validate(input)
    raise "Not Implemented: #{__method__}"
  end

  def question_name
    raise "Not Implemented: #{__method__}"
  end

end



