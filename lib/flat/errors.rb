module Errors #:nodoc:

  # = FlatFileError
  #
  # Generic error class and superclass of all other errors raised by Flat.
  #
  class FlatFileError          < StandardError;     end

  # = LayoutConstructorError
  #
  # The specified layout definition was not valid.
  #
  class LayoutConstructorError < FlatFileError;     end

  # = RecordLengthError
  #
  # Generic error having to do with line lengths not meeting expectations.
  #
  class RecordLengthError      < FlatFileError;     end

  # = ShortRecordError
  #
  # The incoming line was shorter than the defined width.
  #
  class ShortRecordError       < RecordLengthError; end

  # = LongRecordError
  #
  # The incoming line was longer than the defined width.
  #
  class LongRecordError        < RecordLengthError; end

end # => module Errors
