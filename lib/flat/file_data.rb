##
# = FileData
#
# Defines structures and accessors for the internal FileData required by Flat::File
# and its successful operations.
#
module FileData
  module ClassMethods

    ##
    # Container for various points of data as defined in the Flat::File subclass.
    #
    # Returns a +Hash+ with the following keys:
    # * +:width+ - The overall width, or length, of a line in the flat file.
    # * +:pack_format+ - A format +String+ for use by String#unpack.
    # * +:fields+ - An +Array+ of Field::Definitions
    # * +:layouts+ - An +Array+ of Layout::Definitions
    #
    def flat_file_data
      @data ||= {
        :width       => 0,
        :pack_format => '',
        :fields      => [],
        :layouts     => [],
      }
    end

    ##
    # Convenience method for accessing <tt>flat_file_data[:fields]</tt>
    #
    # Returns an +Array+ of Field::Definitions
    #
    def fields
      flat_file_data[:fields]
    end

    ##
    # Convenience method for accessing <tt>flat_file_data[:width]</tt>
    #
    # Returns the overall length of a line to text in the flat file.
    #
    def width
      flat_file_data[:width]
    end

    #
    # Added setter to support +=, -= constructs; also allows direct
    # assignment.
    #
    def width=(value) #:nodoc:
      flat_file_data[:width] = value
    end

    ##
    # Convenience method for accessing <tt>flat_file_data[:pack_format]</tt>
    #
    # Returns a +String+ sutiable for use with String#unpack
    #
    def pack_format
      flat_file_data[:pack_format]
    end

    ##
    # Convenience method for accessing <tt>flat_file_data[:layouts]</tt>
    #
    # Returns an +Array+ of Layout::Definitions
    #
    def layouts
      flat_file_data[:layout]
    end

    #
    # Added for test purposes, primarily. DESTRUCTIVE!
    #
    def reset_file_data #:nodoc:
      @data = nil
    end

  end

  module InstanceMethods

  end

  def self.included receiver #:nodoc:
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end # => module FileData
