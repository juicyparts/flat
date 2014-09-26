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
  spec.homepage      = "https://github.com/juicyparts/flat"
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

  spec.add_runtime_dependency "extlib", "~> 0.9.0"

  spec.add_development_dependency "bundler", ">= 1.6.2" # was "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rdoc", "~> 4.1.0"

  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "rspec-nc", "~> 0.2.0"
  spec.add_development_dependency "guard", "~> 2.6.0"
  spec.add_development_dependency "guard-rspec", "~> 4.3.0"
  spec.add_development_dependency "pry", "~> 0.10.0"
  spec.add_development_dependency "pry-remote", "~> 0.1.0"
  spec.add_development_dependency "pry-nav", "~> 0.2.0"

  spec.add_development_dependency "coveralls", "~> 0.7.0"
end
