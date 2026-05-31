#!/usr/bin/env ruby

def print_arguments
  puts "Arguments:"
  ARGV.each do |arg|
    puts arg
  end
  # Print exactly one empty trailing line
  puts ""
end
