class CommandLineQuestions

  attr_reader :answers, :outstream, :instream
  private :answers, :outstream, :instream

  HUB_URI = 'https://hub.makersacademy.com'
  RANDOMIZE_BYTES_QUESTIONS = [:cohort_id, :number_of_bytes, :base_uri]

  def self.randomize_bytes
    new.ask_questions(*RANDOMIZE_BYTES_QUESTIONS)
  end

  def initialize(outstream: $stdout, instream: $stdin)
    @outstream = outstream
    @instream = instream
    @answers = {}
  end

  def ask_questions(*questions)
    questions.each{ |question| self.send(question) }
    answers
  end

  private

  def cohort_id
    outstream.print "Enter cohort id: "
    response = validate_is_number(instream.gets.chomp)
    answers[:cohort_id] = response.to_i
  end

  def number_of_bytes
    outstream.print "Enter number of bytes: "
    response = validate_is_number(instream.gets.chomp)
    answers[:number_of_bytes] = response.to_i
  end

  def base_uri
    outstream.print "Enter base uri (press enter for #{HUB_URI}): "
    response = instream.gets.chomp
    return answers[:base_uri] = HUB_URI if response.empty?
    answers[:base_uri] = validate_is_url(response)
  end

  def validate_is_url(input)
    invalid_message = "You must enter a valid url e.g. https://example.com"
    raise invalid_message unless is_url?(input)
    input
  end

  def validate_is_number(input)
    invalid_message = "You must enter a valid number"
    raise invalid_message unless is_number?(input)
    input
  end

  def is_number?(input)
    input.to_i.to_s == input
  end

  def is_url?(input)
    input =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
