#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2021-10-07 21:40:59 +0800

while l = gets
  puts l unless l.match(/^[.~]/) || l.match(%r{^\d+/\d})
end
