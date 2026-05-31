#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  uri = URI.parse(url)
  request = Net::HTTP::Post.new(uri)
  
  # Set the header to expect JSON data
  request['Content-Type'] = 'application/json'
  
  # Convert the body parameters to a JSON string
  request.body = JSON.generate(body_params)
  
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end
  
  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  puts response.body
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
