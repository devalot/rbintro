################################################################################
require('minitest/autorun')

################################################################################
module ExceptionBasics; end

################################################################################
class ExceptionBasics::CustomTest < MiniTest::Test

  ##############################################################################
  # <<: class
  class JavaTooSlowError < StandardError
  end
  # :>>

  ##############################################################################
  def test_raising_exception
    assert_raises(JavaTooSlowError) do
      # <<: raise
      raise(JavaTooSlowError, "switch to another language")
      # :>>
    end
  end
end
