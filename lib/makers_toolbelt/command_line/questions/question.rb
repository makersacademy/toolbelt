class Question
  attr_reader :type, :instream, :outstream
  private :type, :instream, :outstream

  def self.call
    new.call
  end

  def initialize(instream: $stdin, outstream: $stdout)
    @instream = instream
    @outstream = outstream
    @type = camel_case(self.class.to_s).to_sym
  end

  def call
    outstream.print "Enter #{requested_data}: "
    {type => validate(instream.gets.chomp)}
  end

  private

  def validate(input)
    invalid_message = "You must enter a valid #{data_type}"
    raise invalid_message unless is_valid?(input)
    input
  end

  def is_valid?(input)
    input.to_i.to_s == input
  end

  def requested_data
    type.to_s.gsub('_', ' ')
  end

  def data_type
    "number"
  end

  def camel_case(string)
    string.gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      .gsub(/([a-z\d])([A-Z])/,'\1_\2')
      .tr("-", "_")
      .downcase
  end

end



