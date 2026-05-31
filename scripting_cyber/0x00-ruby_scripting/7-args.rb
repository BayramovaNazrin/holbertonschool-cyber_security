#!/usr/bin/env ruby

def print_arguments
  puts "Arguments:"
  
  ARGV.each do |arg|
    puts arg
  end
  
  # Print an extra newline to match the desired trailing space
  puts ""
end
