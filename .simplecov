# frozen_string_literal: true

SimpleCov.start do
  add_filter %r{^/.git/}
  add_filter %r{^/.bundle/}
  add_filter %r{^/tmp/}
  add_filter %r{^/coverage/}
  add_filter %r{^/vendor/}
  add_filter %r{^/node_modules/}
  add_filter %r{^/bin/}
  add_filter %r{^/exe/}
  add_filter %r{^/spec/}

  add_group 'Lib', %w[lib/railway/train lib/railway/station lib/railway/route lib/railway/wagon]
  add_group 'Cli', 'lib/railway/cli'

  add_group 'Long files' do |src_file|
    src_file.lines.count > 100
  end

  add_group 'Multiple Files', %w[app/models app/controllers] # You can also pass in an array

  SimpleCov.coverage_dir('results/coverage')
end
