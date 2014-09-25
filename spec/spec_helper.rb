# Setup the RSpec testing environment for Flat:
#
require 'coveralls'
Coveralls.wear!

require 'pry'
require 'flat'

class TestFilter
  def self.filter(value)
    value.upcase
  end

  def filter(value)
    value.reverse
  end
end