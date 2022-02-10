# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flat/version'

Gem::Specification.new do |spec|
  spec.name          = "flat"
  spec.version       = Flat::VERSION
  spec.authors       = ["Mel Riffe"]
  spec.email         = ["mriffe@gmail.com"]
  spec.summary       = %q{Library to make processing Flat Flies as easy as CSV files.}
  spec.description   = %q{Easily process flat files with Flat. Specify the format in a subclass of Flat::File and read and write until the cows come home.}
  spec.homepage      = "http://juicyparts.com/flat/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |name| name.match(/^\.|^G.*|^Rakefile$|^spec.*/) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Ruby 1.9.3 and above
  spec.required_ruby_version = '>= 1.9.3'
  spec.post_install_message = "Thanks for installing!"
  spec.metadata = {
    "source_code"   => 'https://github.com/juicyparts/flat',
    "documentation" => 'http://rubydoc.info/github/juicyparts/flat',
    "issue_tracker" => "https://github.com/juicyparts/flat/issues",
    "wiki"          => "https://github.com/juicyparts/flat/wiki",
  }

  spec.add_development_dependency "bundler", "~> 2.1", ">= 2.1.4"
  spec.add_development_dependency "rake", "~> 12.2"
  spec.add_development_dependency "rdoc", ">= 3.12"

  spec.add_development_dependency "rspec", "~> 3.11.0"
  spec.add_development_dependency "rspec-nc", "~> 0.3.0"
  spec.add_development_dependency "guard", "~> 2.17.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "pry-remote", "~> 0.1.0"
  spec.add_development_dependency "pry-nav", "~> 0.3.0"

  spec.add_development_dependency "coveralls", "~> 0.8.23"
end
