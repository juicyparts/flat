require 'spec_helper'

describe FileData do

  let(:flat_file) { Flat::File }

  describe 'flat_file_data' do
    it 'should be a Hash' do
      expect( flat_file.flat_file_data ).to be_an_instance_of( Hash )
    end

    it 'should have 4 keys' do
      keys = flat_file.flat_file_data.keys
      expect( keys.size ).to eq( 4 )
      expect( keys ).to include( :width )
      expect( keys ).to include( :pack_format )
      expect( keys ).to include( :fields )
    end
  end

  describe 'width' do
    before do
      flat_file.reset_file_data
    end

    it 'has a convenience accessor' do
      expect( flat_file.flat_file_data[:width] ).to eq( flat_file.width )
    end

    it 'defaults to 0' do
      expect( flat_file.width ).to eq( 0 )
    end

    it 'can be changed' do
      flat_file.width += 1
      expect( flat_file.width ).to eq( 1 )

      flat_file.width -= 2
      expect( flat_file.width ).to eq( -1 )

      flat_file.width = 12
      expect( flat_file.width ).to eq( 12 )
    end
  end

end
