#!/usr/bin/env ruby

def print_arguments
  # Check if any arguments were passed
  if ARGV.empty?
    puts "No arguments provided."
  else
    # Loop through each argument stored in ARGV and print it
    ARGV.each do |arg|
      puts arg
    end
  end
end

# Call the method to execute when the script runs
print_arguments
