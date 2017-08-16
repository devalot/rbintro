require('minitest/autorun')
require('candy_bar')

class CandyBarTest < MiniTest::Test

  def setup
    @bar = CandyBar.new("Snickers")
  end

  def test_remaining_bites_starts_at_1
    assert_equal(1.0, @bar.bites)
  end

  def test_bites_goes_down
    starting_value = @bar.bites

    @bar.bite("Peter", 0.5) # Should reduce number of bites
    assert(@bar.bites < starting_value)
  end

  def test_bites_does_not_go_below_zero
    6.times do
      @bar.bite("Peter", 0.22)
    end

    assert(@bar.bites >= 0.0)
  end

  def test_people_method
    @bar.bite("Peter", 0.25)
    @bar.bite("Paul",  0.25)

    assert_equal(["Paul 0.25", "Peter 0.25"],
                 @bar.people.sort)
  end

  def test_average
    @bar.bite("Peter", 0.25)
    @bar.bite("Paul", 0.5)
    @bar.bite("Mary", 0.125)

    assert_equal(0.29, @bar.average_bite_size.round(2))
  end

  def test_hogs
    @bar.bite("Peter", 0.25)
    @bar.bite("Paul", 0.5)
    @bar.bite("Mary", 0.125)

    assert_equal(["Paul"], @bar.hogs)
  end

  def test_can_change_name
    @bar.name = "Awesome!"
    assert_equal("Awesome!", @bar.name)
  end
end
