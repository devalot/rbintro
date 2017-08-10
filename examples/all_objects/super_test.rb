################################################################################
require('minitest/autorun')

################################################################################
module AllObjects; end

################################################################################
class AllObjects::SuperTest < MiniTest::Test

  ##############################################################################
  # <<: parent
  class Parent
    def initialize(x, y)
      @x, @y = x, y

      # Other, important work...
    end
  end
  # :>>

  ##############################################################################
  # <<: child-no-super
  class Child < Parent
    def initialize(a)
      # How to call Parent#initialize method?
    end
  end
  # :>>

  ##############################################################################
  # <<: child
  class Child < Parent
    def initialize(a)
      super(a, a)
    end
  end
  # :>>

  ##############################################################################
  class Shape
    def draw(*)
    end
  end

  ##############################################################################
  # <<: circle
  class Circle < Shape
    def draw(x, y)
      super(1, 2) # Call with 1, 2.
      super(x, y) # Call with x, y.
      super x, y  # Same as above.
      super       # Same as above.
      super()     # Call without arguments.
    end
  end
  # :>>

  ##############################################################################
  def test_all_this_crap
    assert(Child.new(1))
    assert(Circle.new.draw(1, 1).nil?)
  end
end
