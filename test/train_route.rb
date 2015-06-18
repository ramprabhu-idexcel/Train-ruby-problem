require_relative "../lib/city"
require_relative "../lib/destination"
require_relative "../lib/route"
require_relative "../lib/routes"
require_relative "../lib/no_route"
require_relative "../lib/end_of_route"
require "test/unit"

########################## Below test cases belong to Route class ############################################

class TestRoute < Test::Unit::TestCase

  @@route = Route.new 'a', 'b', 5

  @@route_a = Route.new 'a', 'b', 5

  @@route_b = Route.new 'b', 'c', 4

  def test_distance
    assert_equal(5,  @@route.distance)
  end

  def test_only_string
    assert_equal('ab5',  @@route.to_s)
  end

  def test_one_stop
    assert_equal(1,  @@route.stops)
  end

  def test_calculate_dist_of_route
    output = @@route_a.connect @@route_b
    assert_equal(9,  output.distance)
  end

  def test_should_be_string
    output = @@route_a.connect @@route_b
    assert_equal('abc9',  output.to_s)
  end

  def test_maximum_stops
    output = @@route_a.connect @@route_b
    assert_equal(2,  output.stops)
  end


end

########################## Below test cases belong to Routes class ############################################

class TestRoutes < Test::Unit::TestCase

  #can be found by origin, destination and max stops
  def test_with_no_connections
    routes = Routes.new 'ab1 bc2'
    assert_equal(1,  routes.find_by_max_stops('a', 'b').length)
  end

  def test_same_origin_dest_max_6_stops
    routes = Routes.new 'ab1 bc2 ca3'
    assert_equal(2,  routes.find_by_max_stops('a', 'a', 6).length)
  end

  def test_different_orgin_dest
    routes = Routes.new 'ab1 bc2 cd3'
    assert_equal(1,  routes.find_by_max_stops('a', 'd').length)
  end

  def test_no_route_with_invalid_origin
    routes = Routes.new 'ab1 bc2 cd3'
    assert_equal('NO SUCH ROUTE',  routes.find_by_max_stops(nil, 'd')[0].to_s)
  end

  def test_no_route_with_invalid_destination
    routes = Routes.new 'ab1 bc2 cd3'
    assert_equal('NO SUCH ROUTE',  routes.find_by_max_stops('a', nil)[0].to_s)
  end

  #can be found by origin, destination and exact stops

  def test_with_no_connection
    routes = Routes.new 'ab1 bc2'
    assert_equal(1,  routes.find_by_number_of_stops('a', 'b').length)
  end

  def test_same_orgin_desti_with_exact_6_stops
    routes = Routes.new 'ab1 bc2 ca3'
    assert_equal(1,  routes.find_by_number_of_stops('a', 'a', 6).length)
  end

  def test_no_route_with_invalid_dest
    routes = Routes.new 'ab1 bc2 cd3'
    assert_equal('NO SUCH ROUTE',  routes.find_by_number_of_stops('a', nil)[0].to_s)
  end

  #can be found by the shortest of a route for origin and destination

  def test_with_multiple_possible_routes
    routes = Routes.new 'ab1 bc4 bd1 dc1'
    assert_equal('abdc3',  routes.find_by_shortest_route('a', 'c').to_s)
  end

   def test_invalid_such_route
    routes = Routes.new 'ab1 bc2 cd3'
    assert_equal('NO SUCH ROUTE',  routes.find_by_number_of_stops(nil, nil)[0].to_s)
  end

  #can be found by a max distance of a route for origin and destination

  def test_with_multiple_possi_routes
    routes = Routes.new 'ab1 bc4 bd1 dc1'
    assert_equal(2,  routes.find_by_distance_less_than('a', 'c', 6).length)
  end

  def test_no_route_with_invalid_orig
    routes = Routes.new 'ab1 bc2 cd3'
    assert_equal('NO SUCH ROUTE',  routes.find_by_distance_less_than(nil, nil, 3)[0].to_s)
  end

  #when desired route does not exists'
    def test_no_route_with_single_connection
      routes = Routes.new ''
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops('a', 'b').to_s)
    end

    def test_no_route_two_connections
      routes = Routes.new 'ab5 bc4'
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops('a', 'b', 'd').to_s)
    end

    def test_no_route_with_no_cities_required
      routes = Routes.new 'ab5 bc4'
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops().to_s)
    end

    def test_no_such_route_with_no_cities_requried
      routes = Routes.new 'ab5 bc4'
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops('a').to_s)
    end

     # when desired route does not exists
    def test_no_route_single_connection
      routes = Routes.new ''
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops('a', 'b').to_s)
    end

    def test_two_connection_no_route
      routes = Routes.new 'ab5 bc4'
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops('a', 'b', 'd').to_s)
    end

    def test_no_route_no_cities_requested
      routes = Routes.new 'ab5 bc4'
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops().to_s)
    end

    def test_no_route_for_cities_requested
      routes = Routes.new 'ab5 bc4'
      assert_equal('NO SUCH ROUTE',  routes.find_by_exact_stops('a').to_s)
    end

  #when desired route exists'
    def test_find_route_with_no_connection
      routes = Routes.new 'ab5'
      assert_equal('ab5',  routes.find_by_exact_stops('a','b').to_s)
    end

    def test_find_route_with_two_connections
      routes = Routes.new 'ab5 bc4'
      assert_equal('abc9',  routes.find_by_exact_stops('a','b','c').to_s)
    end

    def test_find_route_with_5_connections
      routes = Routes.new 'ab5 bc4 ce3 ed7 da2'
      assert_equal('abceda21',  routes.find_by_exact_stops('a','b','c','e','d','a').to_s)
    end
end

