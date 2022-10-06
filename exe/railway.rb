#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/railway'

loop do
  begin
    puts "Test ... "
    gets.chomp
  rescue SystemExit, Interrupt
    exit 0
  end
end
