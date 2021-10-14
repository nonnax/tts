#!/usr/bin/env ruby
# Id$ nonnax 2021-10-10 21:37:14 +0800
require 'core_ext'

n,a=gets.split(/\t|,/)

class String
	def plus(ts)
		(self.to_ms+ts.to_ms).to_ts#(fmt: "%02d:%02d:%02d.%02d")
	end
	def minus(ts)
		(self.to_ms-ts.to_ms).to_ts#(fmt: "%02d:%02d:%02d.%02d")
	end
	
	def compute(ts)
		if ts[0]=='-'
			ts[0]=='' 
			subt=true
		end
		subt.nil? ? [ts, self.plus(ts)] : [self.minus(ts), ts]
	end

end

print "#{n}\t#{a}\t"
# s=n.compute(a)
# x, sec=s.split(/\./)
# sec="%02d" % [(sec.to_i/1000.to_f)*100]
# print s, "\t", [x, sec].join('.'), "\n"

p n.compute(a).join(" | ")
