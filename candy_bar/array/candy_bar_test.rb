require("minitest/autorun")
require("candy_bar")

class CandyBarTest < MiniTest::Unit::TestCase

  def setup
    @candy = CandyBar.new("Twix")
  end

  def test_max_bites_is_100_percent
    assert_equal(1.0, @candy.bites)

    20.times do
      @candy.bite(0.25)
    end

    assert_equal(0.0, @candy.bites)
  end
end
