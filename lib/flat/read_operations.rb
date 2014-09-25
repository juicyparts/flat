##
# = ReadOperations
#
# Defines functionality required for the successful reading, parsing and
# interpreting of a line of text contained in a flat file.
#
module ReadOperations
  module ClassMethods #:nodoc:
  end # => module ClassMethods

  ##
  # = Instance Methods
  #
  # Defines behavior for instances of a subclass of Flat::File regarding the
  # reading and parsing of the file contents, line by line.
  #
  module InstanceMethods

    # Iterate through each record (each line of the data file). The passed
    # block is passed a new Record representing the line.
    #
    #    s = SomeFile.new
    #    s.each_record(open('/path/to/file')) do |r|
    #      puts r.first_name
    #    end
    #--
    # NOTE: Expects an open valid IO handle; opening and closing is out of scope
    #++
    #
    def each_record io, &block
      io.each_line do |line|
        line.chop!
        next if line.length.zero?

        unless (self.width - line.length).zero?
          raise Errors::RecordLengthError, "length is #{line.length} but should be #{self.width}"
        end

        yield create_record(line, io.lineno), line
      end
    end

  end # => module InstanceMethods

  def self.included receiver #:nodoc:
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

end # => module ReadOperations
