#!/usr/bin/env ruby
require 'json'

def count_user_ids(path)

  file_content = File.read(path)

  
  data = JSON.parse(file_content)

    
  user_ids = data.map { |item| item['userId'] }.compact

  
  user_ids.tally
end
