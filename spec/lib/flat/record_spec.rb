require 'spec_helper'

describe Record do

  let(:flat_file) { Flat::File }

  describe Record::Definition do
    before do
      flat_file.reset_file_data
    end

    it 'creates a new instance' do
      record = Record::Definition.new flat_file, {}, 12
      expect( record.line_number ).to eq( 12 )
      expect( record.attributes ).to be_empty
    end

    it 'has a getter per defined field' do
      flat_file.add_field :field, width: 25
      record = Record::Definition.new flat_file, {field: 'Field'}
      expect( record.field ).to eq( 'Field' )
    end

    it 'has a setter per defined field' do
      flat_file.add_field :field, width: 25
      record = Record::Definition.new flat_file, {field: 'Field'}
      record.field = record.field.upcase
      expect( record.field ).to eq( 'FIELD' )
    end

    it 'throws an error for an unknown attribute' do
      skip 'not capturing raised error correctly'

      record = Record::Definition.new flat_file, {}, 12
      expect( record.field ).to raise_error( Errors::FlatFileError )
    end

  end # => describe Record::Definition

end
