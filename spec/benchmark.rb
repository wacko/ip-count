require 'benchmark'
require './request_counter'
require './advanced_request_counter'

counter = RequestCounter.new
counter2 = AdvancedRequestCounter.new

# Populate with data (100M samples, 20M differents IPs)
100_000_000.times do
  i = rand(20_000_000)
  counter.request_handled(i)
  counter2.request_handled(i)
end

Benchmark.bm do |x|
  x.report("100x RequestCounter")         { 100.times{counter.top100} }
  x.report("100x AdvancedRequestCounter") { 100.times{counter2.top100} }
  x.report("1x RequestCounter")           { counter.top100 }
  x.report("1x AdvancedRequestCounter")   { counter2.top100 }
end
