#!/usr/bin/env ruby
require 'digest'

def crack_password(hashed_password, dictionary_file)
  return unless File.exist?(dictionary_file)

  File.foreach(dictionary_file) do |line|
    word = line.strip
    next if word.empty?

    if Digest::SHA256.hexdigest(word) == hashed_password
      puts word
      return
    end
  end
rescue StandardError
end

if ARGV.length != 2
  puts "Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE"
else
  crack_password(ARGV[0], ARGV[1])
end
