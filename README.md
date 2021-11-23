# IP counter

`request_handled(ip_address)`

  This function accepts a string containing an IP address like “145.87.2.109”. This function will be
  called by the web service every time it handles a request. The calling code is outside the scope of
  this project. Since it is being called very often, this function needs to have a fast runtime.

`top100()`

  This function should return the top 100 IP addresses by request count, with the highest traffic IP
  address first. This function also needs to be fast. Imagine it needs to provide a quick response (<
  300ms) to display on a dashboard, even with 20 millions IP addresses. This is a very important
  requirement. Don’t forget to satisfy this requirement.

`clear()`

  Called at the start of each day to forget about all IP addresses and tallies.

# Implementations

## RequestCounter

This does a simple quicksort over the whole list and picks the first 100 items

## AdvancedRequestCounter

This implementation transverse the list and keep a secondary list of the top 100 elements. This list is updated only when a new candidate appears, reducing the time spent to sort items by ignoring the lower values.


## Benchmark

100M IP addresses (20M unique values)
Measuring top100 (100 times)

```
Complexity
  RequestCounter:         O(n.log(n))
  AdvancedRequestCounter: O(n)       (*)

100x RequestCounter         9609.365689  32.073290 9641.438979 (9645.400542)
100x AdvancedRequestCounter  185.270969   0.079810  185.350779 ( 185.383806)
```

Complexity for AdvancedRequestCounter is in fact `O(n.log(m))`, but n >> m, so the difference is negligible.

