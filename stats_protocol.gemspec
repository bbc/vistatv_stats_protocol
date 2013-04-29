# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stats_protocol/version'

Gem::Specification.new do |gem|
  gem.name          = "stats_protocol"
  gem.version       = StatsProtocol::VERSION
  gem.authors       = ["Dan Nuttall", "Chris Lowis"]
  gem.email         = ["dan.nuttall@bbc.co.uk", "chris.lowis@bbc.co.uk"]
  gem.description   = %q{Shared protocol logic for stats client/server}
  gem.summary       = %q{Shared protocol logic for stats client/server}
  gem.homepage      = "https://github.com/bbcrd/stats_protocol"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"
end
