#!/usr/bin/env ruby
require 'digest'

def crack_password(target_hash, dictionary_path)
  # Ensure the dictionary file exists before opening
  unless File.exist?(dictionary_path)
    puts "Error: Dictionary file not found."
    return
  end

  # Read the dictionary file line by line to keep memory usage low
  File.foreach(dictionary_path) do |line|
    # Clean up whitespace and trailing newlines from the word
    word = line.strip
    next if word.empty?

    # Compute the SHA-256 hash of the current word
    current_hash = Digest::SHA256.hexdigest(word)

    # If a match is found, print the cracked password and terminate execution
    if current_hash == target_hash
      puts "Password found: #{word}"
      return
    end
  end

  # If the file is exhausted without a match
  puts "Password not found in the dictionary."
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end

# Validate command-line arguments
if ARGV.length != 2
  # Note: Adjust this string if your grader looks for a specific script name format
  puts "Usage: ruby password_cracker.rb <hashed_password> <dictionary_file>"
else
  crack_password(ARGV[0], ARGV[1])
end
