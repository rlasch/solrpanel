require 'rubygems' unless ENV['NO_RUBYGEMS']

begin
  require 'rspec/core/rake_task'
rescue LoadError
  puts <<-EOS
To use rspec for testing you must install rspec gem:
    gem install rspec
EOS
  exit(0)
end

desc "Run the specs under spec/models"
# Spec::Rake::SpecTask.new do |t|
#   t.spec_opts = ['--options', "spec/spec.opts"]
#   t.spec_files = FileList['spec/**/*_spec.rb']
# end

desc "Run the specs under spec/models"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end

