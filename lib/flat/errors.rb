module Flat::Errors #:nodoc:

  # = FlatFileError
  #
  # Base class of errors raised by Flat
  #
  class FlatFileError          < StandardError; end
  class LayoutConstructorError < FlatFileError; end
  class ShortRecordError       < FlatFileError; end
  class LongRecordError        < FlatFileError; end
  class RecordLengthError      < FlatFileError; end

end # => module Flat::Errors
