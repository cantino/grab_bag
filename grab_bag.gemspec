# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "grab_bag/version"

Gem::Specification.new do |s|
  s.name        = "grab_bag"
  s.version     = GrabBag::VERSION
  s.authors     = ["Andrew Cantino"]
  s.email       = ["andrew@iterationlabs.com"]
  s.homepage    = "http://github.com/iterationlabs/grab_bag"
  s.summary     = %q{A grab-and-go bag of helpful stuff}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
