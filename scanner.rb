#  NEED TO THINK ABOUT TESTING THIS AGAINST PARTICULAR CHECKOUTS OF STUDENT CODEBASES ...


latest_ruby = false # working on first pass
twilio_ruby_included = false # working on first pass - more general checks for other needed gems? (check for build failure)
rspec_can_run = false # would have to run rspec, supress output and check the result
readme_updated = not(`git diff master README.md`.empty?) # git comparison across branches ... `git diff master README.md`
vacuous_tests = false # would have to mutate tests out and check code coverage stats (not foolproof) - could also check for stubbing method under test ...
sensitive_data = false # could be done with regex

LATEST_RUBY = "* The Gemfile can lock the project to a particular version of Ruby. " \
              " In general you should prefer the latest, currently 2.2.3\n\n"

RUBY_TWILIO = "* Please do include all the gems you use in your Gemfile. This is an important courtesy" \
              " to other developers and yourself in the future, so that all the project" \
              " dependencies can be pulled in whenever the project is checked out on a" \
              " new machine, e.g. `twilio-ruby` gem\n\n"

README_UPDATE = "* Please do update your README following the [contribution notes](https://github.com/makersacademy/takeaway-challenge/blob/master/CONTRIBUTING.md), i.e.\n\n" \
                "  * Make sure you have written your own README that briefly explains your approach to solving the challenge.\n" \
                "  * If your code isn't finished it's not ideal but acceptable as long as you explain in your README where you got to and how you would plan to finish the challenge.\n\n" \
                "* The above is a relatively straightforward thing to do that doesn't involve much programming - I'll often get it done while thinking about other problems in the back of my mind :-)\n\n" \
                "* Also it's a great idea to show the full story of how your app is used (from a user's perspective) in the README, e.g. an irb transcript"

File.foreach('Gemfile').with_index do |line, line_num|
  # require 'byebug' ; byebug
  latest_ruby ||=  !(line =~ /ruby '2\.2\.3'/).nil?
  twilio_ruby_included ||= !(line =~ /gem 'twilio-ruby'/).nil?  # we need to check that ruby-twilio is in fact used somewhere else as well
end

puts LATEST_RUBY unless latest_ruby
puts RUBY_TWILIO unless twilio_ruby_included
puts README_UPDATE unless readme_updated
