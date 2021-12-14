#!/usr/bin/env ruby
# frozen_string_literal: true

# ttsedit.rb
# while editing shows pages and character count
#
# Id$ nonnax 2021-10-08 18:52:50 +0800
require 'rubytools/editor'
require 'rubytools/fzf'
require 'rubytools/time_and_date_ext'
require 'rubytools/string_ext'
require 'fileutils'

f = ARGV.first

exit unless f.text_file? && f.match(/txt|tts|md/)

begin
  f ||= Dir['*.md'].fzf(cmd: 'fzf --preview="nopages.rb {} | cat | format.rb"').first
  # break unless f
  exit unless f

  # backup first
  FileUtils.cp(f, "#{Time.now_to_s}_#{File.basename(f)}")

  res = IO.popen("cat #{f} | format.rb", &:read)
  raise 'No Content Error' if res.chomp.strip.empty?

  # exit
  res.prepend ".TTS\n"
  res = IO.editor(res.chomp)
  text = []
  res.lines.each do |l|
    text << l unless l.match(/^[.~]/) || l.match(%r{^\d+/\d}) || l.match(/^.TTS/)
  end

  File.open(f, 'w') { |io| io.write text.join }
  f = nil
rescue StandardError => e
  p e
end
