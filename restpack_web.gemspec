# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restpack_web/version'

Gem::Specification.new do |spec|
  spec.name          = "restpack_web"
  spec.version       = RestPack::Web::VERSION
  spec.authors       = ["Gavin Joyce"]
  spec.email         = ["gavinjoyce@gmail.com"]
  spec.description   = %q{Rack middleware for your RestPack web apps}
  spec.summary       = %q{Rack middleware}
  spec.homepage      = "http://restpack.org/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "restpack_gem"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bump"
end
