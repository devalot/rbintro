################################################################################
require('minitest/autorun')

################################################################################
class IteratorTest < MiniTest::Unit::TestCase

  ##############################################################################
  def test_iterator_pattern
    # <<: times
    count = 100

    count.times do |i|
      # I'm called 100 times!
    end
    # :>>

    assert(true)
  end
end
