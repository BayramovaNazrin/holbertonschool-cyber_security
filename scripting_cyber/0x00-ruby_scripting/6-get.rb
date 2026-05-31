#!/usr/bin/env ruby
require 'net/http'
require 'uri'

def get_request(url)
  # Parse the URL string into a URI object
  uri = URI.parse(url)
  
  # Perform the HTTP GET request
  response = Net::HTTP.get_response(uri)
  
  # Print the exact format required by the grader
  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  puts response.body
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
