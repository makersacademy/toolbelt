class GeneratePairs
  FILE_EXTENSION = 'pairs'

  attr_reader :source

  def initialize(source:)
    @source = source
  end

  def run
    File.new(path, 'w')
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
