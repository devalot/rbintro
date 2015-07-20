################################################################################
require('minitest/autorun')

################################################################################
module Callbacks; end

################################################################################
class Callbacks::ClassMethTest < MiniTest::Unit::TestCase

  ##############################################################################
  # <<: battery
  class Battery
    attr_accessor(:level)

    def self.full
      new(1.0)
    end

    def self.empty
      new(0.0)
    end

    def initialize (level)
      self.level = level
    end
  end
  # :>>

  ##############################################################################
  def test_battery
    assert_in_delta(1.0, Battery.full.level)
    assert_in_delta(0.0,   Battery.empty.level)
  end
end
