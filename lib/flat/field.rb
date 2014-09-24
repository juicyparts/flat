##
# = Field
#
# A field definition tracks information that's necessary for
# FlatFile to process a particular field.  This is typically
# added to a subclass of FlatFile like so:
#
#  class SomeFile < FlatFile
#    add_field :some_field_name, :width => 35
#  end
#
module Field
  module ClassMethods
    ##
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
    # == Options
    #
    def add_field name = nil, options = {}, &block
      fields << field_def = Field::Definition.new(name, options, self)

      yield field_def if block_given?

      pack_format << "A#{field_def.width}"
      flat_file_data[:width] += field_def.width
      # width += field_def.width # doesn't work for some reason

      return field_def
    end

    ##
    # Add a pad field. To have the name auto generated, use :autoname for
    # the name parameter. For options see +add_field+.
    #
    def pad name, options = {}
      add_field ( name == :autoname ? new_pad_name : name ), options.merge( padding: true )
    end

    private

    ##
    # Used to generate unique names for pad fields which use :auto_name.
    #
    def new_pad_name #:nodoc:
      "pad_#{unique_id}".to_sym
    end

    ##
    # Increments an id counter which is used to generate unique pad names
    #
    def unique_id #:nodoc:
      @unique_id = (@unique_id || 0) + 1
    end

  end

  module InstanceMethods

  end

  def self.included receiver #:nodoc:
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
  class Definition #:nodoc:
    attr_accessor :parent, :name, :width, :padding, :aggressive
    attr_accessor :filters, :formatters, :map_in_proc

    ##
    # Create a new FieldDef, having name and width. parent is a reference to the
    # FlatFile subclass that contains this field definition.  This reference is
    # needed when calling filters if they are specified using a symbol.
    #
    # Options can be :padding (if present and a true value, field is marked as a
    # pad field), :width, specify the field width, :formatter, specify a formatter,
    # :filter, specify a filter.
    #
    def initialize name = null, options = {}, parent = {}
      @parent, @name = parent, name

      @width      = options.fetch(:width, 10)
      @padding    = options.fetch(:padding, false)
      @aggressive = options.fetch(:aggressive, false)

      @filters = @formatters = Array.new

      add_filter(options[:filter])
      add_formatter(options[:formatter])

      @map_in_proc = options[:map_in_proc]
    end

    def padding?
      @padding
    end

    def aggressive?
      @aggressive
    end

    private

    ##
    # Add a filter. Filters are used for processing field data when a flat file is
    # being processed. For fomratting the data when writing a flat file, see
    # add_formatter
    #
    def add_filter filter = nil, &block
      @filters.push(filter) if filter
      @filters.push(block) if block_given?
    end

    ##
    # Add a formatter. Formatters are used for formatting a field
    # for rendering a record, or writing it to a file in the desired format.
    #
    def add_formatter formatter = nil, &block
      @formatters.push(formatter) if formatter
      @formatters.push(block) if block_given?
    end

  end # => class Definition
end
