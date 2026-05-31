#!/usr/bin/env ruby

class CaesarCipher
  # Constructor to initialize the shift value
  def initialize(shift)
    @shift = shift
  end

  # Public method to encrypt a plaintext message
  def encrypt(message)
    cipher(message, @shift)
  end

  # Public method to decrypt a ciphertext message
  def decrypt(message)
    # Decryption is just shifting in the opposite direction
    cipher(message, -@shift)
  end

  # Keep the core logic private so it can only be called within the instance
  private

  # FIXED: Parameter renamed from 'shift_value' to 'shift' to match the pattern
  def cipher(message, shift)
    message.chars.map { |char| shift_char(char, shift) }.join
  end

  # Helper method to handle individual character shifting
  def shift_char(char, shift_value)
    if char.match?(/[a-z]/)
      base = 'a'.ord
      # Ensure the shift wraps around perfectly using the modulo operator
      (((char.ord - base + shift_value) % 26) + base).chr
    elsif char.match?(/[A-Z]/)
      base = 'A'.ord
      (((char.ord - base + shift_value) % 26) + base).chr
    else
      # If it's a space, punctuation, or number, leave it unchanged
      char
    end
  end
end

# --- Demonstration / Testing ---

# 1. Initialize the cipher with a shift of 3
cipher = CaesarCipher.new(3)

# 2. Encrypt a message
secret_message = "Hello, Ruby World! 2026"
encrypted = cipher.encrypt(secret_message)
puts "Original:  #{secret_message}"
puts "Encrypted: #{encrypted}"

# 3. Decrypt the message back
decrypted = cipher.decrypt(encrypted)
puts "Decrypted: #{decrypted}"

# 4. Verifying privacy restriction
begin
  cipher.cipher("Test", 3)
rescue NoMethodError => e
  puts "\nPrivacy Check: Success! Cannot call 'cipher' directly: #{e.message}"
end
