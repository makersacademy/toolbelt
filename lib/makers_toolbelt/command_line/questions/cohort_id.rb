require_relative 'question'

class CohortID < Question

  private

  def validate(input)
    super.to_i
  end
end
