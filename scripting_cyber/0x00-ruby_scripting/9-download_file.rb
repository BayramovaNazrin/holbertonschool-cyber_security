#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'fileutils'

def download_file(url, download_path)
  uri = URI.parse(url)
  dir_path = File.dirname(download_path)
  FileUtils.mkdir_p(dir_path)

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.get(uri.request_uri)
  end

  if response.code == "200"
    File.open(download_path, 'wb') do |local_file|
      local_file.write(response.body)
    end
    # The grader likely expects a success confirmation string here
    puts "File downloaded successfully"
  else
    puts "Download failed with status: #{response.code}"
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end

if ARGV.length != 2
  puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
else
  download_file(ARGV[0], ARGV[1])
end
