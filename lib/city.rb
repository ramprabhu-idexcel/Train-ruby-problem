class City
  attr_reader :name

  def initialize(name)
    @name = name
    @destinations = {}
  end

  def route(city_names)
    return EndOfRoute.new if city_names == nil || city_names.empty?
    destination = @destinations[city_names[0]]
    return NO_ROUTE if destination == nil
    connecting_city_names = city_names.slice 1,city_names.length
    build_route_to(destination).connect_to(connecting_city_names)  if connecting_city_names #Building route based on city object
  end

  def all_routes_to(final_destination, max_stops=15 , stops=0)
    routes = []
    return routes if stops == max_stops
    routes.concat(build_direct_route_to final_destination)
    routes.concat(build_connection_routes_to final_destination, max_stops, stops)
  end

  def build_connection_routes_to(final_destination, max_stops, stops)
    connecting_routes = []
    @destinations.each_value do |destination|
      destination.city.all_routes_to(final_destination, max_stops, stops + 1).each do |connection|
        connecting_routes << build_route_to(destination).connect(connection)
      end
    end
    connecting_routes
  end

  def build_direct_route_to(final_destination)
    direct_route = route(final_destination.name)
    return [] if direct_route == NO_ROUTE
    [direct_route]
  end

  def build_route_to(destination)
    Route.new self, destination.city, destination.distance   #here self is origin
  end

  def empty?
    @name.empty?
  end

  def to_s
    @name
  end

  def add_destination(destination)
    @destinations[destination.city.name] = destination
  end

end