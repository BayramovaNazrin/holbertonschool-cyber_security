#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'

def get_request(url)
  # Parse the URL string into a URI object
  uri = URI.parse(url)
  
  # Perform the HTTP GET request
  response = Net::HTTP.get_response(uri)
  
  # Create a hash containing the status code and response body
  output = {
    "status_code" => response.code.to_i,
    "body" => response.body
  }
  
  # Print the output hash as a pretty-printed JSON string
  puts JSON.pretty_generate(output)
rescue StandardError => e
  # Handle potential errors (e.g., invalid URL, network issues)
  error_output = {
    "error" => e.message
  }
  puts JSON.pretty_generate(error_output)
end

# --- Example Usage ---
# You can uncomment the line below to test it with a live mock API
# get_request('https://jsonplaceholder.typicode.com/posts/1')
