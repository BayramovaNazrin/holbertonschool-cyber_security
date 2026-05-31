#!/usr/bin/env ruby
require 'open-uri'
require 'uri'
require 'fileutils'

def download_file(url, download_path)
  dir_path = File.dirname(download_path)
  FileUtils.mkdir_p(dir_path)

  URI.open(url) do |remote_file|
    File.open(download_path, 'wb') do |local_file|
      local_file.write(remote_file.read)
    end
  end
rescue StandardError => e
  # Keeps the execution clean if an unexpected network blip happens
end

# This ensures the code inside ONLY runs if the file is executed directly from CLI
if __FILE__ == $0
  if ARGV.length != 2
    puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
  else
    download_file(ARGV[0], ARGV[1])
  end
end
