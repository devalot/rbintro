################################################################################
require('minitest/autorun')

################################################################################
module Callbacks; end

################################################################################
class Callbacks::BlockTest < MiniTest::Test

  ##############################################################################
  module BlockGiven
    # <<: block-given
    def open(file_name)
      file = File.open(file_name)
      yield(file) if block_given?
    ensure
      file.close if file
    end
    # :>>

    module_function(:open)
  end

  ##############################################################################
  def test_block_given
    assert(BlockGiven.open("/dev/null"){|f| f}.closed?)
    assert_equal(:foo, BlockGiven.open("/dev/null") {|f| :foo})
  end

  ##############################################################################
  module Explicit
    # <<: explicit
    def open(file_name, &block)
      file = File.open(file_name)
      block.call(file) if block
    ensure
      file.close if file
    end
    # :>>

    module_function(:open)

    # <<: silly
    def silly(&block)
      list = [1, 2, 3]
      list.each(&block)
    end
    # :>>

    module_function(:silly)
  end

  ##############################################################################
  def test_explicit
    assert(Explicit.open("/dev/null"){|f| f}.closed?)
    assert_equal(:foo, Explicit.open("/dev/null") {|f| :foo})
  end

  ##############################################################################
  def test_silly
    list = []
    Explicit.silly {|n| list << n}
    assert_equal([1, 2, 3], list)
  end
end
