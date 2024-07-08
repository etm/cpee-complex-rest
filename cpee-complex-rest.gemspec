Gem::Specification.new do |s|
  s.name             = "cpee-complex-rest"
  s.version          = "1.0.21"
  s.platform         = Gem::Platform::RUBY
  s.license          = "LGPL-3.0"
  s.summary          = "Complex REST calls for the cloud process execution engine (cpee.org)"

  s.description      = "see http://cpee.org"

  s.files            = Dir['{server/**/*,tools/**/*,lib/**/*}'] + %w(LICENSE Rakefile cpee-complex-rest.gemspec README.md AUTHORS)
  s.require_path     = 'lib'
  s.extra_rdoc_files = ['README.md']
  s.bindir           = 'tools'
  s.executables      = ['cpee-complex-rest']

  s.required_ruby_version = '>=2.4.0'

  s.authors          = ['Juergen eTM Mangler']

  s.email            = 'juergen.mangler@gmail.com'
  s.homepage         = 'http://cpee.org/'

  s.add_runtime_dependency 'riddl', '~> 1.0'
end
