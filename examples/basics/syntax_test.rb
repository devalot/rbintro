################################################################################
require('minitest/autorun')

################################################################################
class SyntaxTest < MiniTest::Unit::TestCase

  ##############################################################################
  # <<: person
  class Person
    def initialize (first, last)
      @first_name = first
      @last_name  = last
    end

    def name
      @first_name + " " + @last_name
    end
  end
  # :>>

  ##############################################################################
  def new_person
    # <<: new
    character = Person.new("Sheldon", "Cooper")
    character.name # Returns: "Sheldon Cooper"
    # :>>
    character
  end

  ##############################################################################
  def test_new_person
    assert_equal("Sheldon Cooper", new_person.name)
  end
end
