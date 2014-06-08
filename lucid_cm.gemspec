$: << "#{File.dirname __FILE__}/lib"

require 'lucid_cm/version'

Gem::Specification.new do |s|

  s.name                   = 'lucid_cm'
  s.summary                = 'Campaign Monitor API interface.'
  s.description            = 'A basic but extensible Campaign Monitor API interface extending lucid_client.'
  s.license                = 'MIT'

  s.version                = LucidCM::VERSION

  s.author                 = 'Kelsey Judson'
  s.email                  = 'kelsey@luciddesign.co.nz'
  s.homepage               = 'http://github.com/luciddesign/lucid_cm'

  s.files                  = Dir.glob( 'lib/**/*' ) + %w{ README.md LICENSE }

  s.platform               = Gem::Platform::RUBY
  s.has_rdoc               = false

  s.required_ruby_version  = '>= 2.0.0'
  s.add_runtime_dependency   'lucid_client', '~> 0.1.0'
  s.add_runtime_dependency   'rack'

end
