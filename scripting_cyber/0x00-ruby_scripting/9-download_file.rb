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
end
