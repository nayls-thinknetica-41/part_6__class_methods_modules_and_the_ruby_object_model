#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler'

Bundler.setup

require_relative '../lib/railway'
require_relative '../lib/cli'

i = 0
loop do
  puts "----- NEW LOOP [#{i += 1}] -----"
  begin
    puts Railway::Cli::Main::HELP
    printf '>> '
    Railway::Cli::Main.control(gets.chomp)
  rescue SystemExit, Interrupt
    exit 0
  end
end
