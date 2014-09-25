require 'flat/errors'
require 'flat/file_data'
require 'flat/field'
require 'flat/layout'
require 'flat/record'
require 'flat/read_operations'

# = Flat::File
#
class Flat::File
  include Errors
  include FileData
  include Layout
  include Field
  include Record
  include ReadOperations

end # => class Flat::File
