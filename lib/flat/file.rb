require 'flat/errors'
require 'flat/file_data'
require 'flat/field'
require 'flat/layout'
require 'flat/record'

# = Flat::File
#
class Flat::File
  include Errors
  include FileData
  include Layout
  include Field
  include Record

end # => class Flat::File
