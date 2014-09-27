##
# = Field
#
# A field definition tracks information that's necessary for
# Flat::File to process a particular field.  This is typically
# added to a subclass of Flat::File like so:
#
#  class SomeFile < Flat::File
#    add_field :some_field_name, :width => 35
#  end
#
module Field
  ##
  # = Class Methods
  #
  # Defines behavior for subclasses of Flat::File regarding the specification
  # of the line structure contained in a flat file.
  #
  module ClassMethods

    ##
    # Add a field to the Flat::File subclass.  Options can include
    #
    # :width - number of characters in field (default 10)
    # :filter - callack, lambda or code block for processing during reading
    # :formatter - callback, lambda, or code block for processing during writing
    #
    #  class SomeFile < Flat::File
    #    add_field :some_field_name, :width => 35
    #  end
    #
    # == Options
    #
    def add_field name = nil, options = {}, &block
      fields << field_def = Field::Definition.new(name, options, self)

      yield field_def if block_given?

      pack_format << field_def.pack_format
      self.width += field_def.width

      # TODO: Add a check here to ensure the Field has a name specified; it can be a String or Symbol
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
    # Used to generate unique names for pad fields which use :autoname.
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

  end # => module ClassMethods

  module InstanceMethods #:nodoc:
  end # => module InstanceMethods

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
    attr_reader :parent
    attr_accessor :name, :width
    attr_accessor :filters, :formatters, :map_in_proc

    ##
    # Create a new FieldDef, having name and width. parent is a reference to the
    # Flat::File subclass that contains this field definition.  This reference is
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

      add_filter options[:filter]
      add_formatter options[:formatter]

      @map_in_proc = options[:map_in_proc]
    end

    def padding?
      @padding
    end

    def aggressive?
      @aggressive
    end

    #
    # TODO: Find out what's capable with this pack foramat;
    # String#pack, String#unpack
    #
    def pack_format
      "A#{width}"
    end

    ##
    # Add a filter. Filters are used for processing field data when a flat file is
    # being processed. For fomratting the data when writing a flat file, see
    # add_formatter
    #
    def add_filter filter = nil, &block
      @filters.push( filter ) unless filter.blank?
      @filters.push( block ) if block_given?
    end

    ##
    # Add a formatter. Formatters are used for formatting a field
    # for rendering a record, or writing it to a file in the desired format.
    #
    def add_formatter formatter = nil, &block
      @formatters.push( formatter ) unless formatter.blank?
      @formatters.push( block ) if block_given?
    end

    ##
    # Passes value through the filters defined on this Field::Definition
    #
    def filter value
      @filters.each do |filter|
        value = case filter
            when Symbol
              @parent.public_send filter, value
            when Proc
              if filter.arity == 0
                value
              else
                filter.call value
              end
            when Class, Object
              unless filter.respond_to? 'filter'
                value
              else
                filter.filter value
              end
            else
              value
            end
      end
      value
    end
  end # => class Definition

end # => module Field
