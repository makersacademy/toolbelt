class GetBytes

  private

  def prettified(bytes)
    bytes.each_with_index.inject("") do |output, (byte, byte_number)|
      output << pretty(byte, byte_number)
    end
  end

  def pretty(byte, byte_number)
    output = <<-PRETTY
Byte #{byte_number}
======

PRETTY
    byte.each{|student| output << "#{student[:name]}\n"}
    output << "\n"
  end

end
