# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sequel/pool_cleaner/version'

Gem::Specification.new do |spec|
  spec.name          = "sequel-pool_cleaner"
  spec.version       = Sequel::PoolCleaner::VERSION
  spec.authors       = ["Emarsys Technologies"]
  spec.email         = ["balazs.szerencsi@emarsys.com"]

  spec.summary       = %q{Sequel connection pool cleanup gem.}
  spec.description   = %q{Removes closed connections from the Sequel connection pool.}
  spec.homepage      = "https://github.com/emartech/sequel-pool_cleaner"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
