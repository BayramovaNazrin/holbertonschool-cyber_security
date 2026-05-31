#!/usr/bin/env ruby
require 'optparse'

# Class to parse and hold command-line options
class CLIOptions
  attr_accessor :name, :verbose, :count

  def initialize
    # Set default values
    @name = "Guest"
    @verbose = false
    @count = 1
  end
end

def parse_options
  options = CLIOptions.new

  # Initialize the OptionParser object
  opt_parser = OptionParser.new do |opts|
    opts.banner = "Usage: cli_app.rb [options]"
    opts.separator ""
    opts.separator "Specific options:"

    # 1. String flag that requires an argument
    opts.on("-n", "--name NAME", String, "Name of the user to greet (default: Guest)") do |name|
      options.name = name
    end

    # 2. Boolean switch (flag without an argument)
    opts.on("-v", "--[no-]verbose", "Run verbosely and print debug logs") do |verbose|
      options.verbose = verbose
    end

    # 3. Numeric flag that automatically handles Integer casting
    opts.on("-c", "--count COUNT", Integer, "Number of times to print the message") do |count|
      options.count = count
    end

    opts.separator ""
    opts.separator "Common options:"

    # 4. Standard help message flag
    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
    end
  end

  # Parse ARGV destructively
  opt_parser.parse!(ARGV)
  options

rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
  # Gracefully handle validation/parsing syntax errors from the user
  puts "CLI Error: #{e.message}"
  puts "Run with --help to see valid options."
  exit 1
end

# Execution pipeline
if __FILE__ == $0
  config = parse_options

  if config.verbose
    puts "[DEBUG] Verbose mode enabled."
    puts "[DEBUG] Configuration values: Name=#{config.name}, Count=#{config.count}"
  end

  # Execute application core logic
  config.count.times do |i|
    puts "Hello, #{config.name}! (Iteration #{i + 1})"
  end
end
