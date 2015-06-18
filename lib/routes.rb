class Routes

  #initializing routes object
  def initialize(route_data)
    @cities = {}
    validate_input = route_data.scan(/[a-zA-Z]{2}\d/)  #two character along with digit validation
    unless validate_input.empty?
      validate_input.collect do |route|
        origin = route[0]
        destination = route[1]
        distance = route[2].to_i
        find_or_create_city(origin,destination,distance)
      end
    end
    #puts @cities.inspect
  end

  # Calculate distance between different cities
  def find_by_exact_stops(*args)
    return NO_ROUTE if args.length < 2
    origin = find_city(args[0])   #finding out origin
    origin.route(args.slice(1,args.length))
  end

  def find_by_number_of_stops(origin, destination, number_of_stops=1)
    handle_missing(origin, destination) do
      find_by_max_stops(origin, destination, number_of_stops).select do |route|
        route.stops == number_of_stops
      end
    end
  end

  #finding maximum stops between different cities
  def find_by_max_stops(origin, destination, max_stops=15)
    handle_missing(origin, destination) do
      origin_city = find_city(origin)
      destination_city = find_city(destination)
      origin_city.all_routes_to destination_city, max_stops
    end
  end

  def find_by_shortest_route(origin, destination)
    find_by_max_stops(origin, destination).min { |route_a, route_b| route_a.distance <=> route_b.distance }
  end

  def find_by_distance_less_than(origin, destination, max_distance)
    find_by_max_stops(origin, destination).select { |route| route.distance < max_distance }
  end

  def handle_missing(origin, destination)
    return [NO_ROUTE] if origin == nil || destination == nil
    yield
  end

  private

  #find or creating city
  def find_or_create_city(origin,destination,distance)
    find_city(origin).add_destination(Destination.new(find_city(destination),distance))
  end

  #Creating city objects if it doesn't exist
  def find_city(name)
    @cities[name] = City.new(name) unless @cities.has_key?(name)
    @cities[name]
  end

end