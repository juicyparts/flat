require 'flat/errors'
require 'flat/field'
require 'flat/layout'
require 'flat/record'

# = Flat::File
#
class Flat::File
  include Errors
  include Layout
  include Field
  include Record

end # => class Flat::File
