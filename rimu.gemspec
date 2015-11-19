# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "rimu"
  spec.version       = "0.0.1"
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

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "mocha", "~> 0"
  spec.add_runtime_dependency "httparty", "~> 0.0"
  spec.add_runtime_dependency "json", "~> 1.0"
end
