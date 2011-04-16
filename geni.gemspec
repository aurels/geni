# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geni}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aurélien Malisart", "Matt Johnston"]
  s.date = %q{2011-02-03}
  s.description = %q{A Ruby client to the geni.com API}
  s.email = %q{aurelien.malisart@gmail.com}
  s.executables = []
  
  s.extra_rdoc_files = [
    "README.md"
  ]
  
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage = %q{http://github.com/aurels/geni}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ['lib']
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Ruby client to the geni.com API}
  s.test_files = []

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
    s.add_dependency(%q<oauth2>, ["= 0.1.1"])
    s.add_dependency(%q<json>, ["= 1.5.0"])
    
    s.add_development_dependency("rake", "~> 0.8.7")
    s.add_development_dependency("rspec", "2.5.0")
  end
end
