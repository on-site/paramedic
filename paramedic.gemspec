# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paramedic/version'

Gem::Specification.new do |spec|
  spec.name          = "paramedic"
  spec.version       = Paramedic::VERSION
  spec.authors       = ["Joseph Jaber", "Ryan Cammer"]
  spec.email         = ["mail@josephjaber.com", "ryancammer@gmail.com"]
  spec.summary       = %q{Parameter handler}
  spec.description   = %q{Parameter handler}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rspec"
end
