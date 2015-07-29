################################################################################
require('minitest/autorun')

################################################################################
class MatchLabTest < MiniTest::Unit::TestCase

  ##############################################################################
  def test_number_matchers
    strings = {
      "Portal 15"  => "15",
      "NCC-1701"   => "1701",
      "1 over 3"   => "3",
      "16 has a 6" => "6"
    }

    re = /(\d+)$/

    assert_stings_match(strings, re)
  end

  ##############################################################################
  def test_street_names
    strings = {
      "5678 Hoff St."        => "Hoff",
      "1313 Mockingbird Ln." => "Mockingbird",
      "17B Tape Dr."         => "Tape",
    }

    re = /\s+(\w+)/

    assert_stings_match(strings, re)
  end

  ##############################################################################
  private

  ##############################################################################
  def assert_stings_match (strings, re)
    strings.each do |string, result|
      m = string.match(re)
      assert(m)
      assert_equal(result, m[1])
    end
  end
end
