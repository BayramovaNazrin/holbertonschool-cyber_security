#!/usr/bin/env ruby

class CaesarCipher
  def initialize(shift)
    @shift = shift
  end

  def encrypt(message)
    cipher(message, @shift)
  end

  def decrypt(message)
    cipher(message, -@shift)
  end

  private

  def cipher(message, shift)
    message.chars.map { |char| shift_char(char, shift) }.join
  end

  def shift_char(char, shift_value)
    if char.match?(/[a-z]/)
      base = 'a'.ord
      (((char.ord - base + shift_value) % 26) + base).chr
    elsif char.match?(/[A-Z]/)
      base = 'A'.ord
      (((char.ord - base + shift_value) % 26) + base).chr
    else
      char
    end
  end
end
