#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

def load_tasks
  return [] unless File.exist?(TASKS_FILE)
  File.readlines(TASKS_FILE, chomp: true)
end

def save_tasks(tasks)
  File.open(TASKS_FILE, 'w') { |f| f.puts tasks }
end

def add_task(task)
  tasks = load_tasks
  tasks << task
  save_tasks(tasks)
  puts "Task '#{task}' added."
end

def list_tasks
  tasks = load_tasks
  if tasks.empty?
    puts "No tasks found."
  else
    puts "Tasks:"
    tasks.each { |task| puts task }
  end
end

def remove_task(index_str)
  tasks = load_tasks
  index = index_str.to_i - 1
  if index < 0 || index >= tasks.size
    puts "Invalid index."
    exit 1
  end
  removed = tasks.delete_at(index)
  save_tasks(tasks)
  puts "Task '#{removed}' removed."
end

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"
  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:action] = :add
    options[:task] = task
  end
  opts.on("-l", "--list", "List all tasks") do
    options[:action] = :list
  end
  opts.on("-r", "--remove INDEX", "Remove a task by index") do |index|
    options[:action] = :remove
    options[:index] = index
  end
  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end

parser.parse!

case options[:action]
when :add
  add_task(options[:task])
when :list
  list_tasks
when :remove
  remove_task(options[:index])
else
  puts parser
  exit 1
end
