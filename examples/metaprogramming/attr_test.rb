################################################################################
require('minitest/autorun')

################################################################################
module Metaprogramming; end

################################################################################
class Metaprogramming::AttrTest < MiniTest::Test

  ##############################################################################
  # <<: module
  module Helpers
    def make_attribute(name)
      # Create the "getter".
      define_method(name.to_sym) do
        instance_variable_get("@#{name}".to_sym)
      end

      # Create the "setter".
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set("@#{name}".to_sym, value)
      end
    end
  end
  # :>>

  ##############################################################################
  # <<: class
  class Foo
    extend(Helpers)
    make_attribute(:size)
  end
  # :>>

  ##############################################################################
  # <<: test
  def test_make_attribute
    foo = Foo.new
    assert_equal(1, foo.size = 1)
    assert_equal(1, foo.size)
  end
  # :>>
end
