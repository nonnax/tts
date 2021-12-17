#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2021-10-07 21:15:22 +0800
require 'csv'
require 'rubytools'
require 'core_ext'
require 'array_table'

list = []
Dir['*.mp3'].each do |f|
  t = IO.popen("exiftool '#{f}'", &:readlines)
  next unless t

  t =
    t.grep(/Duration/)
     .first
     .split(/:/, 2)
     .last
     .scan(/\S+/)
     .first
  ts = "0#{t.strip.gsub(/:/, '')}".to_f * 1000
  ms = ts.to_i
  times << ms

  puts [f, (ts / 1000).commify, ms.to_ts].to_csv
rescue  StandardError => e
  next
end

puts [:Total_time, (times.sum / 1000.0).commify, times.sum.to_ts].to_csv
