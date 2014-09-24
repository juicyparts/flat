require 'spec_helper'

describe Flat do

  describe 'Version' do
    it 'should verify current gem version' do
      expect(Flat::VERSION).to eq('0.0.0')
    end
  end

end
