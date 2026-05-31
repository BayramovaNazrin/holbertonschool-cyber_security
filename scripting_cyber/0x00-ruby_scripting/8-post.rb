#!/usr/bin/env ruby
require 'net/http'
require 'uri'

def post_request(url, body_params = {})
  # Parse the URL string into a URI object
  uri = URI.parse(url)
  
  # Create a new HTTP POST request object
  request = Net::HTTP::Post.new(uri)
  
  # Set the form data (body parameters)
  request.set_form_data(body_params)
  
  # Send the request over an HTTP connection
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end
  
  # Print the exact format expected by standard HTTP testing tasks
  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  puts response.body
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
