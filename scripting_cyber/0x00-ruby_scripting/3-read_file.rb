#!/usr/bin/env ruby
require 'json'

def count_user_ids(path)
  # 1. Read the raw text from the file path
  file_content = File.read(path)

  # 2. Parse the raw JSON text into a Ruby array/hash structure
  data = JSON.parse(file_content)

  # 3. Map through the data to collect all 'userId' values, then count them
  # (Using .compact ensures we don't count objects that might be missing a userId)
  user_ids = data.map { |item| item['userId'] }.compact

  # 4. Return the total count
  user_ids.tally
end
