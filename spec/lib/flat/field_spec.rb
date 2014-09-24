require 'spec_helper'

describe Field do

  let(:flat_file) { Flat::File }

  describe Field::Definition do
    describe 'instance creation' do
      it 'should add a new field definition given minimum required information' do
        # Minimum required fields are not enforced, just 'nice to have'.
        field = flat_file.add_field :name, width: 5
        expect( field ).to be_an_instance_of( Field::Definition )
        expect( field.parent ).to eq( flat_file )
        expect( field.name ).to   eq( :name )
        expect( field.width ).to  eq( 5 )
        expect( field.padding? ).to    be false
        expect( field.aggressive? ).to be false
        expect( field.filters ).to    be_empty
        expect( field.formatters ).to be_empty
        expect( field.map_in_proc ).to be_nil
      end
    end
  end # => describe Field::Definition

  describe 'add_field' do
    before do
      flat_file.reset_file_data
    end

    it 'adds 1 field to flat file' do
      flat_file.add_field :test, width: 20
      expect( flat_file.fields.size ).to eq( 1 )
      expect( flat_file.width ).to eq( 20 )
      expect( flat_file.pack_format ).to eq( 'A20' )
    end

    it 'adds 2 fields to flat file' do
      flat_file.add_field :test, width: 17
      flat_file.add_field :test, width: 23
      expect( flat_file.fields.size ).to eq( 2 )
      expect( flat_file.width ).to eq( 40 )
      expect( flat_file.pack_format ).to eq( 'A17A23' )
    end

    it 'adds a field via a block' do
      flat_file.add_field do |fd|
        fd.name = :test
        fd.width = 15
      end
      expect( flat_file.fields.size ).to eq( 1 )
      expect( flat_file.width ).to eq( 15 )
      expect( flat_file.pack_format ).to eq( 'A15' )
    end
  end

  describe 'pad' do
    before do
      flat_file.reset_file_data
    end

    it 'adds a named pad field to flat file' do
      pad_field = flat_file.pad :test, width: 12
      expect( pad_field.name ).to eq( :test )
      expect( flat_file.fields.size ).to eq( 1 )
      expect( flat_file.width ).to eq( 12 )
      expect( flat_file.pack_format ).to eq( 'A12' )
    end

    it 'adds an auto named pad field to flat file' do
      pad_field = flat_file.pad :autoname, width: 3
      expect( pad_field.name ).to eq( :pad_1 )
      expect( flat_file.fields.size ).to eq( 1 )
      expect( flat_file.width ).to eq( 3 )
      expect( flat_file.pack_format ).to eq( 'A3' )
    end
  end

end
