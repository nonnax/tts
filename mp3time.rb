#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2021-10-07 21:15:22 +0800
require 'rubytools/core_ext'
times = []
Dir['*.mp3'].each do |f|
  t = IO.popen("exiftool #{f}", &:readlines).grep(/Duration/).first.split(/:/, 2).last.scan(/\S+/).first
  ts = "0#{t.strip}.000"
  ms = ts.to_ms
  p [ts, ms]
  times << ms
end
p [:Total_time, times.sum.to_ts]
