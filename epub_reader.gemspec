# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'epub_reader/version'

Gem::Specification.new do |spec|
  spec.name          = "epub_reader"
  spec.version       = EpubReader::VERSION
  spec.authors       = ["Yang-Hsing Lin"]
  spec.email         = ["yanghsing.lin@gmail.com"]
  spec.description   = %q{epub_reader is a gem to parse epub file, including it's htmls and images}
  spec.summary       = %q{epub_reader is a gem to parse epub file, including it's htmls and images}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
