require 'flat/errors'
require 'flat/file_data'
require 'flat/field'
require 'flat/layout'
require 'flat/record'
require 'flat/read_operations'

# = Flat::File
#
# Flat files are typically plain/text files containing many lines of text, or
# data. Each line, or record, consists of one or more fields. However, unlike
# CSV (comma separated value) files, there are no delimiters to define where
# values end or begin. Flat provides a mechanism of defining a file's record
# structure, allowing users to iterate over a given file and access its data as
# typical Ruby objects (String, Numeric, Date, Booleans, etc.).
#
# == Specification
#
# A flat file's specification is defined within the subclass of Flat::File. The
# use of <tt>add_field</tt> and <tt>pad</tt> define and document the record
# structure.
#
#    # Actual plain text, flat file data, 29 bytes
#    #
#    #           10        20
#    # 012345678901234567890123456789
#    # Walt      Whitman   18190531
#    # Linus     Torvalds  19691228
#
#    class People < Flat::File
#      add_field :first_name, width: 10, filter: :trim
#      add_field :last_name,  width: 10, filter: ->(v) { v.strip }
#      add_field :birthday,   width: 8,  filter: BirthdayFilter
#      pad       :autoname,   width: 2
#
#      def self.trim(v)
#        v.strip
#      end
#    end
#
# You will notice the minimum required information is field name and width. The
# special case is with <tt>pad</tt>; you can specify a name but the general
# approach is to let Flat::File name it for you.
#
# An alternate method of specifying fields is to pass a block to the
# <tt>add_field</tt> method. When using the block method you do not have to
# specify the name first. However, you do need to set the name inside the
# block. The value yielded to the block is an instance of Field::Definition.
#
#    class People < Flat::File
#      add_field do |fd|
#        fd.name = :first_name
#        fd.width = 10
#        fd.add_filter ->(v) { v.strip }
#        fd.add_formatter ->(v) { v.strip }
#      end
#
#      add_field :last_name do |fd|
#        fd.width = 10
#        fd.add_filter ->(v) { v.strip }
#        fd.add_formatter ->(v) { v.strip }
#      end
#
#    end
#
# == Reading Data
#
# After your Flat::File has been defined you will be able to read data from
# an actual file. Flat::File does not manage the opening and closing of Files
# or other IO instances (e.g. StringIO).
#
#    data_file = File.open('somefile.dat', 'r')
#
#    People.new.each_record(data_file) do |person|
#      puts "First Name: #{person.first_name}" # => Walter
#      puts "Last Name : #{person.last_name}"  # => White
#      puts "Birthday  : #{person.birthday}"   # => 19590907
#    end
#
#    data_file.close
#
# +each_record+ yields a Record::Definition and the line of text that
# produced it. This object will respond to the field names defined by
# +add_field+. Plus, depending on the filters defined, the resulting data
# can be nearly any Ruby type: String, Symbol, Boolean, Date, etc. This allows
# you to deal with the data as it was intended.
#
# == Writing Data
#
# <em>Slated for a future release.</em>
#
# == Filters
#
# When adding new fields you can specify a filter through which the incoming
# data will be passed. In the absence of a filter the resulting values from the
# Record::Definition will be the raw text as found in the flat file.
#
# You can define filters in 1 of four ways: Symbol, Proc, Class, or Object.
#
# Operationally they all function the same way: used when reading the raw text
# in the file to produce a filtered value for storage in a Record::Definition.
#
# === Defined as a Symbol
#
#    add_field :first_name, width: 10, filter: :trim
#
# +trim+, in this case, must be defined on the Flat::File subclass.
#
#    def self.trim(v)
#      v.strip
#    end
#
# Use this method when more control over the filtering is required, such as
# handling Date parsing errors.
#
# === Defined as a Proc
#
#    add_field :last_name,  width: 10, filter: ->(v) { v.strip }
#
# The proc is stored and later called when needed. If the filtering
# requirements are easy and direct, this method is appropriate.
#
# === Defined as a Class or Object
#
#    add_field :birthday,   width: 8,  filter: BirthdayFilter
#    add_field :birthday,   width: 8,  filter: BirthdayFilter.new
#
# The Class or Object used must respond to +filter+. This method is very
# similar to the +Symbol+ method, expect there is only 1 method to define.
#
#    def self.filter(v)
#      date = Date.parse(v) rescue $!
#      return date unless date.is_a? ArgumentError
#      nil
#    end
#
#    def filter(v)
#      self.class.filter(v)
#    end
#
# == Formatters
#
# <em>Slated for a future release.</em>
#
# == Layouts
#
# <em>Slated for a future release.</em>
#
# == Exceptions
#
# * +FlatFileError+ - Generic error class and superclass of all other errors raised by Flat.
# * +LayoutConstructorError+ - The specified layout definition was not valid.
# * +RecordLengthError+ - Generic error having to do with line lengths not meeting expectations.
# * +ShortRecordError+ - The incoming line was shorter than expectations defined.
# * +LongRecordError+ - The incoming line was longer than expectations defined.
#
class Flat::File
  include Errors
  include FileData
  include Layout
  include Field
  include Record
  include ReadOperations

end # => class Flat::File
