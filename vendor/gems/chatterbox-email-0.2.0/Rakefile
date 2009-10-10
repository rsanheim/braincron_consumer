require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "chatterbox-email"
    gem.summary = %Q{Send emails via chatterbox}
    gem.description = %Q{Send emails via chatterbox - see chatterbox main project for details}
    gem.email = "rsanheim@gmail.com"
    gem.homepage = "http://github.com/rsanheim/chatterbox-email"
    gem.authors = ["Rob Sanheim"]
    gem.add_development_dependency "spicycode-micronaut"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'micronaut/rake_task'
Micronaut::RakeTask.new(:examples) do |examples|
  examples.pattern = 'examples/**/*_example.rb'
  examples.ruby_opts << '-Ilib -Iexamples'
end

Micronaut::RakeTask.new(:rcov) do |examples|
  examples.pattern = 'examples/**/*_example.rb'
  examples.rcov_opts = '-Ilib -Iexamples'
  examples.rcov = true
end

task :examples => :check_dependencies

task :default => :examples

task :release => [:default, "gemcutter:release"]

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "chatterbox-email #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
