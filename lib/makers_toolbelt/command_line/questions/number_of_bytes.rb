require_relative 'question'
require './lib/makers_toolbelt/patches/string'

class NumberOfBytes < Question
  using StringPatches

  private

  def validate(input)
    raise "You must enter a valid number" unless input.is_positive_number?
    input.to_i
  end

  def question_name
    :number_of_bytes
  end

  def question_text
    "Enter number of bytes: " 
  end
end
