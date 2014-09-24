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

TODO: Write usage instructions here

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
