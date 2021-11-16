require 'benchmark'
require './request_counter'

# Populate with data (20M samples, 1M differents IPs)
counter = RequestCounter.new
20_000_000.times{ |i| counter.request_handled(rand(1_000_000)) }

Benchmark.bm do |x|
  x.report { counter.top100 }
end
