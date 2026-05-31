#!/usr/bin/env ruby
require 'net/http'
require 'uri'

def get_request(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  
  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  
  # If the body is just an empty JSON object, format it across two lines
  if response.body == "{}"
    puts "{"
    puts "}"
  else
    puts response.body
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
