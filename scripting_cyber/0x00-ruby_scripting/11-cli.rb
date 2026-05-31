#!/usr/bin/env ruby
require 'optparse'

options = {}
TASK_FILE = "tasks.txt"

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

# Core Task Management Logic
if options[:add]
  File.open(TASK_FILE, "a") do |file|
    file.puts(options[:add])
  end

elsif options[:list]
  if File.exist?(TASK_FILE) && !File.zero?(TASK_FILE)
    puts "Tasks:"
    File.readlines(TASK_FILE).each do |task|
      puts task.strip
    end
  end

elsif options[:remove]
  if File.exist?(TASK_FILE)
    tasks = File.readlines(TASK_FILE)
    idx = options[:remove].to_i - 1

    if idx >= 0 && idx < tasks.length
      tasks.delete_at(idx)
      File.open(TASK_FILE, "w") do |file|
        tasks.each { |t| file.puts(t) }
      end
    end
  end
end
