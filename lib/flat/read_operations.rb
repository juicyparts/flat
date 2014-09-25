##
# = ReadOperations
#
# Defines functionality required for the successful reading, parsing and
# interpreting of a line of text contained in a flat file.
#
module ReadOperations
  module ClassMethods #:nodoc:

  end

  module InstanceMethods #:nodoc:

  end

  def self.included receiver #:nodoc:
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end # => module ReadOperations
