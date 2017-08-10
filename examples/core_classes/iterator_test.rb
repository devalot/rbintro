################################################################################
require('minitest/autorun')

################################################################################
module CoreClasses; end

################################################################################
class CoreClasses::IteratorTest < MiniTest::Test

  ##############################################################################
  def test_array_iterator
    # <<: array-iterator
    # New array:
    a = [1, 2, 3]

    # Long form:
    a.each do |n|
      puts(n)
    end

    # Short form:
    a.each {|n| puts(n)}
    # :>>
  end

  ##############################################################################
  def test_array_select
    # <<: array-select
    # New array:
    a = [1, 2, 3]

    # New array `b' created from `a':
    b = a.select {|n| n > 2}

    # The `b' array should be [3]:
    assert_equal([3], b)
    # :>>
  end

  ##############################################################################
  private

  ##############################################################################
  def puts(*)
  end
end
