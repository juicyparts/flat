module Field
  module ClassMethods

    #
    # Add a field to the FlatFile subclass.  Options can include
    #
    # :width - number of characters in field (default 10)
    # :filter - callack, lambda or code block for processing during reading
    # :formatter - callback, lambda, or code block for processing during writing
    #
    #  class SomeFile < FlatFile
    #    add_field :some_field_name, :width => 35
    #  end
    #
    def add_field

    end

    #
    # Add a pad field. To have the name auto generated, use :auto_name for
    # the name parameter.  For options see add_field.
    #
    def pad

    end

  end

  module InstanceMethods

  end

  def self.included(receiver) #:nodoc:
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  # = Definition
  # Used in Flat::File subclasses to define how a Record is defined.
  #
  #  class SomeFile < Flat::File
  #    add_field :some_field_name, :width => 35
  #  end
  #
  class Definition
  end
end