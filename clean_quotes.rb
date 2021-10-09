#!/usr/bin/env ruby
# frozen_string_literal: true

require 'core_ext'
NEWLINE = "\n" * 2
lines = File.read(ARGV.first)
clean = {
  '“' => '"',
  '”' => '"',
  '’' => '\'',
  '‘' => '\'',
  /^A Discovery of Witches\s*$/ => NEWLINE,
  /^Fangirlish\s*$/ => NEWLINE,
  /^AMC\s*$/ => NEWLINE,
  /^We Heart It\s*$/ => NEWLINE,
  /^Tumblr\s*$/ => NEWLINE,
  /^.+Tumblr\s*$/ => NEWLINE,
  /^The Nerd Daily\s*$/ => NEWLINE
}
#
# lines.map{|e|
clean.each do |k, v|
  lines.gsub!(k, v)
end

# e
# }

puts lines.wrap(160)
