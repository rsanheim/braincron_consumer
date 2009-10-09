require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "braincron_consumer"
    gem.summary = %Q{Message consumer for Braincron}
    gem.description = %Q{Consumes messages, tells Chatterbox to send them along to the right place}
    gem.email = "rsanheim@gmail.com"
    gem.homepage = "http://github.com/rsanheim/braincron_consumer"
    gem.authors = ["Rob Sanheim"]
    gem.add_development_dependency "spicycode-micronaut"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'micronaut/rake_task'
Micronaut::RakeTask.new(:spec) do |specs|
  specs.pattern = 'spec/**/*_spec.rb'
  specs.ruby_opts << '-Ilib -Ispec'
end

Micronaut::RakeTask.new(:rcov) do |specs|
  specs.pattern = 'spec/**/*_spec.rb'
  specs.rcov_opts = '-Ilib -Ispec'
  specs.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

task :environment do
  require "lib/braincron"
end

namespace :consumer do
  desc "Start consumer"
  task :start => :environment do
    Braincron.boot!
  end
  
  task :stop do
  end
end