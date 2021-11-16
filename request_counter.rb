class RequestCounter < Hash
  def initialize
    super 0
  end

  def request_handled(ip_address)
    self[ip_address] = self[ip_address] + 1
  end
end
