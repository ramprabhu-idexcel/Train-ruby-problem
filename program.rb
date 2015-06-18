require File.dirname(__FILE__) + '/lib/city.rb'
require File.dirname(__FILE__) + '/lib/destination.rb'
require File.dirname(__FILE__) + '/lib/route.rb'
require File.dirname(__FILE__) + '/lib/routes.rb'
require File.dirname(__FILE__) + '/lib/no_route.rb'
require File.dirname(__FILE__) + '/lib/end_of_route.rb'


routes = Routes.new 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'   #Building routes object -> combination of various cities along with distance

# 1. The distance of the route A-B-C.
puts "Output #1 #{routes.find_by_exact_stops('A','B','C').distance}"

# 2. The distance of the route A-D.
puts "Output #2 #{routes.find_by_exact_stops('A','D').distance}"

# 3. The distance of th,e route A-D-C.
puts "Output #3 #{routes.find_by_exact_stops('A','D','C').distance}"

# 4. The distance of the route A-E-B-C-D.
puts "Output #4 #{routes.find_by_exact_stops('A','E','B','C','D').distance}"

# 5. The distance of the route A-E-D.
puts "Output #5 #{routes.find_by_exact_stops('A','E','D')}"

# 6. The number of trips starting at C and ending at C with a maximum of 3 stops.  In the sample data below, there are two such trips: C-D-C (2 stops). and C-E-B-C (3 stops).
puts "Output #6 #{routes.find_by_max_stops('C', 'C', 3).length}"

# 7. The number of trips starting at A and ending at C with exactly 4 stops.  In the sample data below, there are three such trips: A to C (via B,C,D); A to C (via D,C,D); and A to C (via D,E,B).
puts "Output #7 #{routes.find_by_number_of_stops('A', 'C', 4).length}"

# 8. The length of the shortest route (in terms of distance to travel) from A to C.
puts "Output #8 #{routes.find_by_shortest_route('A', 'C').distance}"

# 9. The length of the shortest route (in terms of distance to travel) from B to B.
puts "Output #9 #{routes.find_by_shortest_route('B', 'B').distance}"

# 10. The number of different routes from C to C with a distance of less than 30.  In the sample data, the trips are: CDC, CEBC, CEBCDC, CDCEBC, CDEBC, CEBCEBC, CEBCEBCEBC.
puts "Output #10 #{routes.find_by_distance_less_than('C', 'C', 30).length}"

