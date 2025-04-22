# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ticktok/version"

Gem::Specification.new do |spec|
  spec.name        = "ticktok"
  spec.version     = Ticktok::VERSION
  spec.authors     = ["Mumen Musa"]
  spec.email       = ["mumen@musa.ai"]
  spec.summary     = %q{A gem for tracking time for benchmarks}
  spec.description = %q{Ticktok provides a simple way to measure and track execution time in your Ruby code}
  spec.homepage    = "https://github.com/mumenmusa/ticktok"
  spec.license     = "MIT"

  spec.files         = Dir["lib/**/*", "LICENSE.txt", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
