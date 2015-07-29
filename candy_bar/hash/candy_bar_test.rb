require("minitest/autorun")
require("candy_bar")

class CandyBarTest < MiniTest::Unit::TestCase

  def setup
    @candy = CandyBar.new("Twix")
  end

  def test_hog_is_correct
    @candy.bite(0.6, "Peter")
    @candy.bite(0.2, "Jerry")
    @candy.bite(0.3, "Kevin")
    assert_equal("Peter", @candy.hog)
  end

  def test_max_bites_is_100_percent
    assert_equal(1.0, @candy.bites)

    20.times do
      @candy.bite(0.25, "Peter")
    end

    assert_equal(0.0, @candy.bites)
  end

  def test_people_method
    assert_equal([], @candy.people)

    @candy.bite(0.5, "Peter")
    assert_equal(["Peter ate 50.0%"], @candy.people)
  end
end
