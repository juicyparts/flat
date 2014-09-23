require 'errors'
require 'file/laout'
require 'file/field'
require 'file/record'

class Flat::File
  include File::Layout
  include File::Field
  include File::Record

end # => class Flat::File
