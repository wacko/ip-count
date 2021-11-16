class RequestCounter < Hash
  def initialize
    super 0
  end

  def request_handled(ip_address)
    self[ip_address] = self[ip_address] + 1
  end

  def top100
    answer = self.sort_by {|_key, value| value}
    answer.reverse_each.first(100).map{|x|x[0]}
  end
end
