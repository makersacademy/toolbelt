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
    File.open(path, 'w') do |file|
      
      if names.count.odd?
        names << 'Flying solo' # Will pair a lone person up with a dummy 'flying solo' message
      end
      
      pairs = names.one_factorize.shuffle.to_json
      
      file.write pairs
      puts "Pair assignments created in file #{path}"
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
