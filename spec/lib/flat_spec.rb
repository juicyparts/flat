require 'spec_helper'
require 'flat_file_helper'

describe Flat do

  describe 'Version' do
    it 'should verify current gem version' do
      expect(Flat::VERSION).to eq('0.1.3.pre')
    end
  end

  describe 'Operations' do
    let(:person_file) { PersonFile.new }
    let(:data)        { PersonFile::EXAMPLE_FILE }
    let(:lines)       { data.split("\n") }
    let(:stream)      { StringIO.new(data) }

    it 'reads data from a flat file' do
      count = 0
      person_file.each_record( stream ) do |x, y|
        count += 1
      end
      expect( count ).to eq( lines.size )
    end

  end # => describe 'Operations'

end
