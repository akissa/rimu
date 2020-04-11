# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rimu/version'

Gem::Specification.new do |spec|
  spec.name          = "rimu"
  spec.version       = Rimu::Version::VERSION
  spec.authors       = ["Andrew Colin Kissa"]
  spec.email         = ["andrew@topdog.za.net"]
  spec.license       = "MPL-2.0"

  spec.summary       = %q{Ruby bindings for the Rimuhosting REST API}
  spec.description   = %q{This is a Ruby wrapper around Rimuhosting's REST API}
  spec.homepage      = "https://github.com/akissa/rimu"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 1.9.3'
  spec.extra_rdoc_files = ['README.md']

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "mocha", "~> 0"
  spec.add_runtime_dependency "httparty", ">= 0.10.0"
  spec.add_runtime_dependency "json", "~> 1.0"
end
