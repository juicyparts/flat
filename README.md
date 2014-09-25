# Flat

[![Build Status](https://travis-ci.org/juicyparts/flat.svg?branch=develop)](https://travis-ci.org/juicyparts/flat)
[![Coverage Status](https://coveralls.io/repos/juicyparts/flat/badge.png?branch=develop)](https://coveralls.io/r/juicyparts/flat?branch=develop)

Flat is a library to make processing Flat Flies as easy as CSV files. Easily process flat files with Flat. Specify the format in a subclass of Flat::File and read and write until the cows come home.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flat'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flat

## Usage

A simple example for a flat file class for grabbing information about
people might look like this:

    # Actual plain text, flat file data, 29 bytes
    #
    #           10        20
    # 012345678901234567890123456789
    # Walt      Whitman   18190531
    # Linus     Torvalds  19691228

    class People < Flat::File

      add_field :first_name, :width => 10, :filter => :trim
      add_field :last_name,  :width => 10, :filter => :trim
      add_field :birthday,   :width => 8,  :filter => lambda { |v| Date.parse(v) }
      pad       :autoname,  :width => 2

      def self.trim(v)
        v.trim
      end

    end

    p = People.new

    p.each_record(open('somefile.dat')) do |person|

      puts "First Name: #{person.first_name}"
      puts "Last Name : #{person.last_name}"
      puts "Birthday : #{person.birthday}"

      puts person.to_s
    end

Consult the [RDocs](http://rubydoc.info/github/juicyparts/flat) for additional examples, and information on Filters and
Formatters.

## Contributing

1. Fork it ( https://github.com/juicyparts/flat/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Inspiration

I had been looking for a library to handle flat files in a manner similar to
the CSV library and stumbled upon the following:

* flat_filer (http://rubygems.org/gems/flat_filer)
* flat_filer (https://github.com/xforty/flat_filer)
* flat_filer (https://github.com/cheapRoc/flat_filer)

They all appeared to be abandoned so I decided to resurrect them with my own
spin on the implementation.

# LICENSE

Copyright (c) 2014 Mel Riffe

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
