# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','lyra_version.rb'])

require 'rake'

dependencies = Hash[
  'gli', '~> 1.6.0',
  'musicbrainz-ruby', '~> 0.4.0',
  'locale', '~> 2.0.5',
  'mb-discid', '~> 0.1.5',
  'terminal-table', '~> 1.4.5'
]

dev_dependencies = Hash[
  'cucumber', '~> 1.1.9',
  'aruba', '0.4.11',
  'rspec', '~> 2.9.0',
  'pry', '~> 0.9.9.4'
]

spec = Gem::Specification.new do |s| 
  s.name = 'lyra'
  s.version = Lyra::VERSION
  s.author = 'Jason Voegele'
  s.email = 'jason@jvoegele.com'
  s.homepage = 'http://jvoegele.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Lyra is the open source, cross-platform CD ripper for the discerning audiophile.'
  s.files = FileList[
    'bin/*', 'lib/**/*.rb'
  ].to_a
  s.test_files = FileList['features/**/*', 'spec/**/*'].to_a
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README','lyra.rdoc']
  s.rdoc_options << '--title' << 'lyra' << '--main' << 'README' << '-ri'
  s.bindir = 'bin'
  s.executables << 'lyra'
  dependencies.each do |gem, version|
    s.add_dependency(gem, version)
  end
  dev_dependencies.each do |gem, version|
    s.add_development_dependency(gem, version)
  end
end
