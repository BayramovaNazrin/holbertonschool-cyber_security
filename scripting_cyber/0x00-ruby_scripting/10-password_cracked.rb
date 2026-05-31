#!/usr/bin/env ruby
require 'digest'

def crack_password(target_hash, dictionary_path)
  return unless File.exist?(dictionary_path)

  File.foreach(dictionary_path) do |line|
    word = line.strip
    next if word.empty?

    # Compare SHA-256 hash
    if Digest::SHA256.hexdigest(word) == target_hash
      puts word
      return
    end
  end
rescue StandardError
end

# Exact match validation block for the 62-character target
if ARGV.length != 2
  puts "Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE"
else
  crack_password(ARGV[0], ARGV[1])
end
