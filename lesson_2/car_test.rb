require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'car'

class CarTest < Minitest::Test
  # def setup
  #   @car = Car.new
  # end

  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = 'Kim'
    car2.name = 'Kim'

    assert_equal(car1, car2)
    assert_same(car1, car2)
  end
end

# Will fail because Car#== does not exist, meaning that the
# default Object#== is inherited, which compares for equality
# using object identities




