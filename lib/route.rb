class Route
  attr_reader :destination

  def initialize(origin = nil, destination = nil, distance = 0)
    @origin = origin
    @destination = destination
    @distance = distance
    @connection = EndOfRoute.new
  end

  def stops
    1 + @connection.stops
  end

  def distance
    @distance + @connection.distance    #A-B-c  =>  adding distance between A & B & C
  end

  def destination_s
    @connection.destination.empty? ? @destination.to_s : ''
  end

  def connection_s
    @origin.to_s + destination_s + @connection.connection_s
  end

  def to_s
    connection_s + distance.to_s
  end

  def connect(route)     #Finally it returns route object
    @connection = route
    self
  end

  def connect_to(city_names)
    connection = @destination.route(city_names)   #Here destination is a city object
    return connection if connection == NO_ROUTE
    connect connection
  end

end