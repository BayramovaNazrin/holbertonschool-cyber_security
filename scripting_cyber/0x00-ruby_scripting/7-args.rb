#!/usr/bin/env ruby

def print_arguments
  puts "Arguments:"
  
  ARGV.each_with_index do |arg, index|
    puts "#{index + 1}. #{arg}"
  end
  
  # Print the final trailing empty line
  puts ""
end
