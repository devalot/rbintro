################################################################################
require('minitest/autorun')

################################################################################
module CoreClasses; end

################################################################################
module UsingAnArray

  ##############################################################################
  class CandyBar
    attr_accessor(:name)

    # <<: using-array
    def initialize (name)
      @name  = name
      @bites = []
    end

    def bites
      total = 0.0
      @bites.each {|bite| total += bite}
      1.0 - total
    end

    def bite (amount)
      @bites << amount if bites - amount >= 0.0
      amount
    end
    # :>>
  end

  ##############################################################################
  class CandyBarTest < MiniTest::Unit::TestCase

    def test_can_take_bite
      candy = CandyBar.new("Finite Bar")
      candy.bite(0.5)
      assert_in_delta(0.5, candy.bites)
    end

    def test_does_not_go_over_100_percent
      candy = CandyBar.new("Finite Bar")
      candy.bite(0.5)
      candy.bite(0.6)
      assert_in_delta(0.5, candy.bites)

      candy.bite(0.5)
      assert_in_delta(0.0, candy.bites)
    end
  end
end

################################################################################
module UsingAHash

  ##############################################################################
  class CandyBar
    attr_accessor(:name)

    def initialize (name)
      @name  = name
      @bites = {}
    end

    # <<: using-hash
    def bites
      total = 0.0
      @bites.values.each {|bite| total += bite}
      1.0 - total
    end

    def bite (amount, person)
      if bites - amount >= 0.0
        so_far = @bites[person] || 0.0
        @bites[person] = so_far + amount
      end

      amount
    end
    # :>>

    # <<: people
    def people
      @bites.map do |person, percent|
        "#{person} #{percent}"
      end
    end
    # :>>

    # <<: people-better
    def people_better
      @bites.map do |person, percent|
        "%s %0.1f" % [person, percent]
      end
    end
    # :>>

    # <<: hogs
    def hogs
      return [] if @bites.size.zero?

      total = 0
      @bites.values.each {|bite| total += bite}

      average = total / @bites.size
      @bites.select {|person, bite| bite > average}.keys
    end
    # :>>
  end

  ##############################################################################
  class CandyBarTest < MiniTest::Unit::TestCase

    def test_can_take_bite
      candy = CandyBar.new("Finite Bar")
      candy.bite(0.5, "foo")
      assert_in_delta(0.5, candy.bites)
    end

    def test_does_not_go_over_100_percent
      candy = CandyBar.new("Finite Bar")
      candy.bite(0.5, "foo")
      candy.bite(0.6, "bar")
      assert_in_delta(0.5, candy.bites)

      candy.bite(0.5, "bar")
      assert_in_delta(0.0, candy.bites)

      # <<: people-test
      assert_equal("bar 0.5, foo 0.5",
                   candy.people.sort.join(", "))
      # :>>

      # <<: people-better-test
      assert_equal("bar 0.5, foo 0.5",
                   candy.people_better.sort.join(", "))
      # :>>
    end

    # <<: hogs-test
    def test_hogs
      candy = CandyBar.new("Finite Bar")
      candy.bite(0.1, "Peter")
      candy.bite(0.1, "Paul")
      candy.bite(0.5, "Mary")
      assert_equal(["Mary"], candy.hogs)
    end
    # :>>
  end
end
