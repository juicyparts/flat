##
# = Record
#
# A record abstracts on line or 'record' of a fixed width field.
# The methods available are the keys of the hash passed to the constructor.
# For example the call:
#
#  h = Hash['first_name','Andy','status','Supercool!']
#  r = Record::Definition.new(h)
#
# would respond to r.first_name, and r.status yielding
# 'Andy' and 'Supercool!' respectively.
#
#
module Record
  module ClassMethods #:nodoc:
  end # => module ClassMethods

  ##
  # = Instance Methods
  #
  # Defines behavior for instances of a subclass of Flat::File regarding the
  # creating of Records from a line of text from a flat file.
  #
  module InstanceMethods

    ##
    # create a record from line. The line is one line (or record) read from the
    # text file. The resulting record is an object which. The object takes signals
    # for each field according to the various fields defined with add_field or
    # varients of it.
    #
    # line_number is an optional line number of the line in a file of records.
    # If line is not in a series of records (lines), omit and it'll be -1 in the
    # resulting record objects. Just make sure you realize this when reporting
    # errors.
    #
    # Both a getter (field_name), and setter (field_name=) are available to the
    # user.
    #
    #--
    # NOTE: No line length checking here; consider making protected
    #++
    #
    def create_record line, line_number = -1
      attributes = {}
      values = line.unpack pack_format # Parse the incoming line
      fields.each_with_index do |field, index|
        attributes[field.name] = field.filter values[index]
      end
      Record::Definition.new self.class, attributes, line_number
    end

  end # => module InstanceMethods

  def self.included receiver #:nodoc:
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  # = Definition
  #
  # Defines the behavior of a Record.
  #
  class Definition #:nodoc:
    attr_reader :parent, :attributes, :line_number

    #
    # Create a new Record from a Hash of attributes.
    #
    def initialize parent, attributes = {}, line_number = -1
      @parent, @attributes, @line_number = parent, attributes, line_number

      @attributes = parent.fields.inject({}) do |map, field|
        map.update(field.name => attributes[field.name])
      end
    end

    #
    # Catches method calls and returns field values or raises an Error.
    #
    def method_missing method, params = nil
      if method.to_s =~ /^(.*)=$/
        if attributes.has_key?($1.to_sym)
          @attributes.store($1.to_sym, params)
        else
          raise Errors::FlatFileError, "Unknown method: #{method}"
        end
      else
        if attributes.has_key?(method)
          @attributes.fetch(method)
        else
          raise Errors::FlatFileError, "Unknown method: #{method}"
        end
      end
    end
  end # => class Definition

end # => module Record
