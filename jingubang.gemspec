lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'jingubang/version'

Gem::Specification.new do |s|
  s.name        = 'jingubang'
  s.version     = Jingubang::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Zhichao Feng']
  s.email       = ['flankerfc@gmail.com']
  s.homepage    = 'https://github.com/flanker'
  s.summary     = 'All-in-on weixin integration for Rails'
  s.description = 'All-in-on weixin integration for Rails'
  s.license     = 'MIT'

  s.required_ruby_version     = '>= 2.3'
  s.required_rubygems_version = '>= 1.3.6'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- test/*`.split("\n")
  s.require_path = ['lib']

  s.add_dependency 'weixin_message_encryptor'
end
