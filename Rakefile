# frozen_string_literal: true

require 'rspec/core/rake_task'

task default: %w[spec yard]

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  nil
end

begin
  require 'yard'

  YARD::Rake::YardocTask.new(:yard) do |t|
    t.files         = %w[lib/**/*.rb spec/**/*_spec.rb] # optional
    t.options       = %w[--any --extra --opts]          # optional
    t.stats_options = %w[--list-undoc]                  # optional
  end
rescue LoadError
  nil
end
