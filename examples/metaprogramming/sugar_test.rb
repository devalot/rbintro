################################################################################
require('minitest/autorun')

################################################################################
module Metaprogramming; end

################################################################################
class Metaprogramming::SugarTest < MiniTest::Unit::TestCase

  ##############################################################################
  module WithSugar
    # <<: class-sugar
    class Foo < Object
      def initialize
        # ...
      end
    end
    # :>>

    # <<: mod-sugar
    module Bar
      def bar
        # ...
      end
    end
    # :>>
  end

  ##############################################################################
  module WithoutSugar
    # <<: class-sugarfree
    Foo = Class.new(Object) do
      def initialize
        # ...
      end
    end
    # :>>

    # <<: mod-sugarfree
    Bar = Module.new do
      def bar
        # ...
      end
    end
    # :>>
  end


  ##############################################################################
  def test_classes
    [WithSugar::Foo, WithoutSugar::Foo].each do |klass|
      assert(klass.new)
    end
  end

  ##############################################################################
  def test_modules
    [WithSugar::Bar, WithoutSugar::Bar].each do |mod|
      mod.instance_methods.include?(:bar)
    end
  end
end
