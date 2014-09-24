# = Layout
# *EXPERIMENTAL*
#
# If a flat file contains several different record structures, defining
# more than one Layout::Definition allows Flat::File to easily process
# the file.
#
# *EXPERIMENTAL*
#
module Layout
  module ClassMethods #:nodoc:

  end

  module InstanceMethods #:nodoc:

  end

  def self.included(receiver) #:nodoc:
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  # = Definition
  # Add the ability to have multiple layouts per flat flat.
  #
  # EXPERIMENTAL
  #
  class Definition
  end
end # => module Layout
