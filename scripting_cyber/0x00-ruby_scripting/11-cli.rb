#!/usr/bin/env ruby
require 'optparse'

options = {}

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", "Remove a task by index") do |index|
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end

begin
  opt_parser.parse!(ARGV)
rescue OptionParser::ParseError => e
  puts e.message
  exit 1
end

# Core task-handling logic placeholder (remember not to write/push to tasks.txt!)
if options[:add]
  # Add task logic
elsif options[:list]
  # List tasks logic
elsif options[:remove]
  # Remove task logic
end
