require 'extlib'

require 'flat/version'
require 'flat/file'

# = Flat
#
# Flat files are typically plain/text files containing many lines of text, or
# data. Each line, or record, consists of one or more fields. However, unlike
# CSV (comma spearated value) files, there are no delimiters to define where
# values end or begin. Flat provides a mechaism of defining a file's record
# structure, allowing users to iterate over a given file and access its data as
# typical Ruby objects (String, Numeric, Date, Booleans, etc.).
#
# == Specification
#
# A flat file's specification is defined within the subclass of Flat::File. The
# use of <tt>add_field</tt> and <tt>pad</tt> define and document the record
# structure.
#
# Given the following
#    # Actual plain text, flat file data, 29 bytes
#    #
#    #           10        20
#    # 012345678901234567890123456789
#    # Walt      Whitman   18190531
#    # Linus     Torvalds  19691228
#
#    class People < Flat::File
#      add_field :first_name, :width => 10
#      add_field :last_name,  :width => 10
#      add_field :birthday,   :width => 8
#      pad       :autoname,   :width => 2
#    end
#
# You will notice the minimum required information is field name and width. The
# special case is with <tt>pad</tt>; you can specifiy a name but the general
# approach is to let Flat::File name it for you.
#
# An alternate method of specifying fields is to pass a block to the
# <tt>add_field</tt> method. When using the block method you do not have to
# specifiy the name first. However, you do need to set the name inside the
# block. The value yieled to the block is an instance of Field::Definition.
#
#    class People < FlatFile
#      add_field do |fd|
#        fd.name = :first_name
#        fd.width = 10
#        fd.add_filter { |v| v.trim }
#        fd.add_formatter { |v| v.trim }
#      end
#
#      add_field :last_name do |fd|
#        fd.width = 10
#        fd.add_filter { |v| v.trim }
#        fd.add_formatter { |v| v.trim }
#      end
#
#    end
#
# == Reading Data
#
# == Writing Data
#
# == Filters
#
# == Formatters
#
# == Exceptions
#
# * +FlatFileError+ - Generic error class and superclass of all other errors raised by Flat.
# * +LayoutConstructorError+ - The specified layout definition was not valid.
# * +RecordLengthError+ - Generic error having to do with line lengths not meeting expectations.
# * +ShortRecordError+ - The incoming line was shorter than expections defined.
# * +LongRecordError+ - The incoming line was longer than expections defined.
#
module Flat

end

