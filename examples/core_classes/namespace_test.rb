################################################################################
require('minitest/autorun')

################################################################################
module CoreClasses; end

################################################################################
class CoreClasses::NamespaceTest < MiniTest::Unit::TestCase

  ##############################################################################
  # <<: module
  module Climate
    SEASONS = %w(Spring Summer Fall Winter)

    class Weather
      # ...
    end
  end
  # :>>

  ##############################################################################
  def test_weather
    # <<: weather
    weather = Climate::Weather.new
    # :>>

    assert(weather)
  end
end
