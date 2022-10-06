# frozen_string_literal: true

require 'rspec/core/rake_task'

task default: %w[spec yard]

begin
  require 'yard'

  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']          # optional
    t.options = %w[--any --extra --opts] # optional
    t.stats_options = ['--list-undoc']   # optional
  end
rescue LoadError
  nil
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  nil
end
