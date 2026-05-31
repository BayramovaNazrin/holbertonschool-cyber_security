#!/usr/bin/env ruby
require 'open-uri'
require 'uri'
require 'fileutils'

def download_file(url, download_path)
  # Extract the directory name from the target path
  dir_path = File.dirname(download_path)

  # Use FileUtils to ensure parent directories exist before writing
  FileUtils.mkdir_p(dir_path)

  # Open the URL and write the binary content directly to the local file
  URI.open(url) do |remote_file|
    File.open(download_path, 'wb') do |local_file|
      local_file.write(remote_file.read)
    end
  end
  
  puts "Download complete!"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end

# Check for the correct number of arguments before executing
if ARGV.length != 2
  puts "Usage: ruby script.rb <URL> <PATH>"
else
  download_file(ARGV[0], ARGV[1])
end
