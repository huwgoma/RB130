require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class TestExample < Minitest::Test
  def setup
    @str1 = 'Hello'
    @str2 = 'Hello'
  end

  def test_value_equality
    assert_equal(@str1, @str2)
  end

  def test_identity_equality
    assert_same(@str1, @str2)
  end
end











# assert equal uses the #== of the (expected) object.
# # class Float # Integer
# #   def ==(other)
# #     false
# #   end
# # end