# -*- encoding: utf-8 -*-
require File.expand_path('../lib/is_publishable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brendan Stennett"]
  gem.email         = ["brendan@unknowncollective.com"]
  gem.description   = %q{Gives a resouce the ability to be published against a certain date}
  gem.summary       = %q{Created published and published_at attrbutes for a model and allows them to be queried against.}
  gem.homepage      = "https://github.com/HuffMoody/is_publishable"

  gem.files         = Dir.glob("{bin,lib}/**/*") + %w(README.md)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "is_publishable"
  gem.require_paths = ["lib"]
  gem.version       = IsPublishable::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "activerecord"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rake"
end
