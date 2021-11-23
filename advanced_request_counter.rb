class AdvancedRequestCounter < Hash
  Counter = Struct.new(:value, :quantity)
  MAX_RESULTS = 100

  def initialize
    super 0
  end

  def request_handled(ip_address)
    self[ip_address] = self[ip_address] + 1
  end

  def top100
    lower_threshold = 0
    top_elems = []

    each do |ip, occurrences|
      # creates a list of IPs, ordered by total occurrences, with a limit of MAX_RESULTS values
      if top_elems.count < MAX_RESULTS || occurrences > lower_threshold
        position = top_elems.bsearch_index{|x| x.quantity < occurrences } || top_elems.count
        top_elems.insert(position, Counter.new(ip, occurrences))

        top_elems.pop if top_elems.count > MAX_RESULTS
        lower_threshold = top_elems.last.quantity
      end
    end

    top_elems.map{|x| x.value}
  end
end
