################################################################################
require('minitest/autorun')
require('yaml')

################################################################################
module Callbacks; end

################################################################################
class Callbacks::FileTest < MiniTest::Unit::TestCase

  ##############################################################################
  module Example

    # <<: open
    def parse_file (file_name)
      File.open(file_name) do |file|
        file.pos
      end
    end
    # :>>

    module_function(:parse_file)
  end

  ##############################################################################
  def test_parse_file
    f = Example.parse_file('/dev/null')
    assert_equal(0, f)
  end
end
