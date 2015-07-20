################################################################################
require('minitest/autorun')

################################################################################
module CandyBarManualAccessors

  ##############################################################################
  # <<: getter
  class CandyBar
    def initialize (name)
      @name = name
    end
    def name
      @name
    end
  end
  # :>>

  ##############################################################################
  # <<: setter
  class CandyBar
    def name= (name)
      @name = name
    end
  end
  # :>>
end

################################################################################
class CandyBarManualTest < MiniTest::Unit::TestCase

  ##############################################################################
  include(CandyBarManualAccessors)

  ##############################################################################
  def test_getter
    # <<: getter-example
    candy = CandyBar.new("Peanut Butter Kiss")
    candy.name
    # :>>
    assert(candy.name)
  end

  ##############################################################################
  def test_setter
    # <<: setter-example
    candy = CandyBar.new("Whatchamacallit")
    candy.name = "Thingamajig"
    # :>>
    assert_equal("Thingamajig", candy.name)
  end
end

################################################################################
module CandyBarAutoAccessors

  ##############################################################################
  # <<: with-accessors
  class CandyBar
    attr_accessor('name')
    attr_reader('bites')

    def initialize (name)
      @name  = name
      @bites = 5
    end

    def bite
      @bites -= 1
    end
  end
  # :>>
end

################################################################################
class CandyBarAutoTest < MiniTest::Unit::TestCase

  ##############################################################################
  include(CandyBarAutoAccessors)

  ##############################################################################
  def test_getter
    candy = CandyBar.new("Peanut Butter Kiss")
    candy.name
    assert(candy.name)
  end

  ##############################################################################
  def test_setter
    candy = CandyBar.new("Whatchamacallit")
    candy.name = "Thingamajig"
    assert_equal("Thingamajig", candy.name)
  end
end

################################################################################
module CandyBarWarning

  ##############################################################################
  # <<: warning
  class CandyBar
    def initialize (the_name)
      name      = the_name # This is a local variable.
      self.name = the_name # Calls the setter method.
    end

    def name= (name)
      @name = name
    end
  end
  # :>>
end

################################################################################
class CandyBarWarningTest < MiniTest::Unit::TestCase

  ##############################################################################
  include(CandyBarWarning)

  ##############################################################################
  def test_setter
    candy = CandyBar.new("Whatchamacallit")
    assert_equal("Whatchamacallit", candy.instance_variable_get(:@name))
  end
end


################################################################################
module CandyBarSymbolAccessors

  ##############################################################################
  class CandyBar
    # <<: with-string
    # Using a String...
    attr_accessor('name')
    # :>>
  end

  ##############################################################################
  class CandyBar; remove_method(:name); remove_method(:name=); end

  ##############################################################################
  class CandyBar
    # <<: with-symbol
    # Using a Symbol...
    attr_accessor(:name)
    # :>>
  end
end

################################################################################
class CandyBarSymbolTest < MiniTest::Unit::TestCase

  ##############################################################################
  include(CandyBarSymbolAccessors)

  ##############################################################################
  def test_getter
    candy = CandyBar.new
    candy.name = "Foo"
    assert(candy.name)
  end
end

################################################################################
module CandyBarConditional

  ##############################################################################
  class CandyBar
    attr_accessor(:name)
    attr_reader(:bites)
    def initialize (name); @bites = 5; @name = name; end

    # <<: bite-if
    # From CandyBar...
    def bite
      @bites -= 1 if @bites > 0
    end
    # :>>
  end
end

################################################################################
class CandyBarConditionalTest < MiniTest::Unit::TestCase

  ##############################################################################
  include(CandyBarConditional)

  ##############################################################################
  # <<: bite-test
  # From CandyBarTest...
  def test_bites_cannot_go_below_zero
    candy = CandyBar.new("Finite Bar")
    assert_operator(candy.bites, :>, 0)

    (candy.bites + 1).times do
      candy.bite
    end

    assert_equal(0, candy.bites)
  end
  # :>>
end
