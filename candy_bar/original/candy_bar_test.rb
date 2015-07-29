require("minitest/autorun")
require("candy_bar")

class CandyBarTest < MiniTest::Unit::TestCase

  def setup
    # Anything in here will be run
    # before each test
    @candy = CandyBar.new("Butterfingers")
  end

  def test_name_method_works
    candy = CandyBar.new("Butterfingers")
    assert_equal("Butterfingers", candy.name)
  end

  def test_bites_starts_out_at_five
    candy = CandyBar.new("Hershey Kisses")
    assert_equal(5, candy.bites)
  end

  def test_bites_goes_down_by_one
    candy = CandyBar.new("Dirty Dumpster")
    previous_value = candy.bites

    candy.bite # Reduce
    assert_equal(previous_value - 1, candy.bites)
  end

  def test_bites_never_goes_below_zero
    candy = CandyBar.new("Heath Bar")

    10.times do
      candy.bite
    end

    refute_equal(9, candy.bites)
    assert_equal(0, candy.bites)
  end
end
