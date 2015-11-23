require 'one_factorization'
require 'json'

class GeneratePairs
  FILE_EXTENSION = 'pairs'

  attr_reader :source

  def self.load_names(file_path)
    File.readlines(file_path).map(&:strip)
  end

  def initialize(options = {})
    @source = options[:source]
  end

  def run
    names = GeneratePairs.load_names(source)
    file = File.new(path, 'w')
    puts "Pair assignments created in file #{path}"
    begin
      file.write names.one_factorize.to_json
    ensure
      file.close
    end
  end

  def path
    File.join(source_directory, filename)
  end

  private

  def source_directory
    File.dirname(source)
  end

  def filename
    "#{File.basename(source)}.#{FILE_EXTENSION}"
  end
end
