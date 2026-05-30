#!/usr/bin/env ruby
require 'json'

def count_user_ids(path)
  # 1. Read and parse the JSON file
  file_content = File.read(path)
  data = JSON.parse(file_content)

  # 2. Extract all the userIds into an array, removing any nils
  user_ids = data.map { |item| item['userId'] }.compact

  # 3. Tally them up! This automatically counts occurrences of each ID
  # and returns a Hash like: { 1 => 10, 2 => 8, ... }
  counts = user_ids.tally
  counts.each do |id, count|
    puts "#{id}: #{count}"
  end
end
