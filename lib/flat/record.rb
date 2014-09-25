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

  end

  ##
  # = Instance Methods
  #
  # Defines behavior for instances of a subclass of Flat::File regarding the
  # creating of Records from a line of text from a flat file.
  #
  module InstanceMethods

    ##
    #
    # NOTE: No line length checking here; consider making protected
    def create_record line, line_number = -1
      attributes = {}
      values = line.unpack pack_format # Parse the incoming line
      fields.each_with_index do |field, index|
        attributes[field.name] = field.filter values[index]
      end
      Record::Definition.new self.class, attributes, line_number
    end

  end

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
    # Create a new Record from a Hash of attributes
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

  end
end # => module Record
