require_relative 'question'

class NumberOfBytes < Question

  private

  def validate(input)
    super.to_i
  end
end
