################################################################################
# <<: require
require('minitest/autorun')
# :>>

################################################################################
# <<: candy_bar
class CandyBar
  def initialize (name)
    @name  = name
    @bites = 5
  end
  def name
    @name
  end
  def bites
    @bites
  end
  def bite
    @bites -= 1
  end
end
# :>>

################################################################################
# <<: candy_bar_test
class CandyBarTest < MiniTest::Unit::TestCase

end
# :>>

################################################################################
class CandyBarTest

  ##############################################################################
  # <<: initial
  def test_bites_starts_out_correct
    candy = CandyBar.new("Chocolate Dream")
    assert_equal(5, candy.bites, "number of bites")
  end
  # :>>

  ##############################################################################
  # <<: name
  def test_name_is_correct
    candy = CandyBar.new("Melted Butter")
    assert_equal("Melted Butter", candy.name)
  end
  # :>>

  ##############################################################################
  # <<: bites
  def test_bites_goes_down
    candy = CandyBar.new("Lumpy Chocolate")
    current = candy.bites
    candy.bite
    assert_equal(current - 1, candy.bites)
  end
  # :>>
end
