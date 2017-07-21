require_relative 'question'
require './lib/makers_toolbelt/patches/string'

class CohortID < Question
  using StringPatches

  private

  def validate(input)
    raise "You must enter a valid number" unless input.is_positive_number?
    input.to_i
  end

  def question_name
    :cohort_id
  end

  def question_text
    "Enter cohort id: " 
  end
end
