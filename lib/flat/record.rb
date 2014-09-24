module Record
  module ClassMethods #:nodoc:

  end

  module InstanceMethods #:nodoc:

  end

  def self.included(receiver) #:nodoc:
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  # = Definition
  #
  class Definition
  end
end # => module Record
