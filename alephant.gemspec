# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'alephant/version'

Gem::Specification.new do |s|
  s.name        = 'alephant'
  s.version     = Alephant::VERSION
  s.date        = '2014-01-08'
  s.summary     = "Static Publishing in the Cloud"
  s.description = "Static publishing to S3 based on SQS messages"
  s.authors     = ["Robert Kenny"]
  s.email       = 'kenoir@gmail.com'
  s.license     = 'GPLv3'

  s.files       = `git ls-files`.split($/)
  s.platform    = "java"
  s.homepage    =
    'http://rubygems.org/gems/alephant'
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"

  s.add_runtime_dependency 'aws-sdk', '~> 1.0'
  s.add_runtime_dependency 'mustache', '>= 0.99.5'
end