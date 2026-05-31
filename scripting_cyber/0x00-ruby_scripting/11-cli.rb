#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

def add_task(task)
  File.open(TASKS_FILE, 'a') { |f| f.puts(task) }
  puts "Task '#{task}' added."
end

def list_tasks
  if File.exist?(TASKS_FILE)
    tasks = File.readlines(TASKS_FILE).map(&:chomp)
    if tasks.empty?
      puts "No tasks found."
    else
      tasks.each_with_index { |task, i| puts "#{i+1}. #{task}" }
    end
  else
    puts "No tasks found."
  end
end

def remove_task(index)
  unless File.exist?(TASKS_FILE)
    puts "No tasks file found."
    return
  end

  tasks = File.readlines(TASKS_FILE).map(&:chomp)
  if index < 1 || index > tasks.length
    puts "Invalid index. Please provide a number between 1 and #{tasks.length}."
    return
  end

  removed = tasks.delete_at(index - 1)
  File.open(TASKS_FILE, 'w') { |f| f.puts(tasks) }
  puts "Task '#{removed}' removed."
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", Integer, "Remove a task by index") do |index|
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end.parse!

if options[:add]
  add_task(options[:add])
elsif options[:list]
  list_tasks
elsif options[:remove]
  remove_task(options[:remove])
else
  puts "No option provided. Use -h for help."
end
