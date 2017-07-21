require 'makers_toolbelt/patches/string'

RSpec.describe String do
  using StringPatches

  describe '#is_positive_number?' do

    it 'is true if "1"' do
      string = "1"

      expect(string.is_positive_number?).to eq true
    end

    it 'is false if zero' do
      string = "0"

      expect(string.is_positive_number?).to eq false
    end

    it 'is false if negative' do
      string = "-1"

      expect(string.is_positive_number?).to eq false
    end

    it 'is false if "123 bla bla"' do
      string = "123 bla bla"

      expect(string.is_positive_number?).to eq false
    end
  end
end
