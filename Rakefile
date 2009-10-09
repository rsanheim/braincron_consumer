require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "braincron_consumer"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
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

namespace :consumer do
  task :start do
    Braincron.start!
  end
  
  task :stop do
  end
end