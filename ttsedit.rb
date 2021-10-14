#!/usr/bin/env ruby
# frozen_string_literal: true

# ttsedit.rb
# while editing shows pages and character count
#
# Id$ nonnax 2021-10-08 18:52:50 +0800
require 'editor'
require 'fzf'
require 'fileutils'

f = ARGV.first

exit unless f.match(/tts|md/)

loop do
  f ||= Dir['*.md'].fzf(cmd: 'fzf --preview="nopages.rb {} | cat | format.rb"').first
  break unless f

  FileUtils.cp(f, "#{f}.bak")

  res = IO.popen("cat #{f} | format.rb", &:read)
  res.prepend ".TTS\n"
  res = IO.editor(res.chomp)
  text = []
  res.lines.each do |l|
    text << l unless l.match(/^[.~]/) || l.match(%r{^\d+/\d}) || l.match(/^.TTS/)
  end

  File.open(f, 'w') { |io| io.write text.join }
  f = nil
end
