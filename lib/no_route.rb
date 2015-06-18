class NoRoute

  def <=>(other)
    self.to_s == other.to_s
  end

  def distance
    0
  end

  def connect(route)
  end

  def stops
    0
  end

  def destination
    ''
  end

  def destination_s
    ''
  end

  def connection_s
    ''
  end

  def to_s
    'NO SUCH ROUTE'
  end
end

NO_ROUTE = NoRoute.new