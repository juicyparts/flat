require 'flat/errors'
require 'flat/file/layout'
require 'flat/file/field'
require 'flat/file/record'

class Flat::File #:nodoc:

  include File::Layout
  include File::Field
  include File::Record

end # => class Flat::File
