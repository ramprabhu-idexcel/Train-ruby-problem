class Destination
  attr_reader :city, :distance
  def initialize(city, distance)
    @city = city
    @distance = distance
  end
end