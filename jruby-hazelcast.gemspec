# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jruby-hazelcast}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Denenberg"]
  s.date = %q{2010-06-22}
  s.description = %q{}
  s.email = %q{adam@dberg.org}
  s.extra_rdoc_files = [
    "LICENSE",
     "README"
  ]
  s.files = [
    "INSTALL",
     "LICENSE",
     "README",
     "Rakefile",
     "VERSION",
     "hazelcast.yml",
     "lib/hazelcast-1.8.4.jar",
     "lib/hazelcast-client-1.8.4.jar",
     "lib/jruby-hazelcast.rb"
  ]
  s.homepage = %q{http://github.com/denen99/jruby-hazelcast}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{ruby interface to Hazelcast Cache Cluster}
  s.test_files = [
    "examples/test1.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

