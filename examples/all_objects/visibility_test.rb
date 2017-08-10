################################################################################
require('minitest/autorun')

################################################################################
module AllObjects; end

################################################################################
class AllObjects::VisibilityTest < MiniTest::Test

  ##############################################################################
  # <<: shape
  class Shape
    # The initialize method is private by default.
    def initialize; end

    # Other methods are public by default.
    def color; end

    private # Everything after this is private by default.

    # Private because above.
    def destroy; end

    # But can be changed.
    public(:destroy)
  end
  # :>>

  ##############################################################################
  def test_instance_methods
    assert_equal([:color, :destroy], Shape.public_instance_methods(false))
    assert_equal([:initialize], Shape.private_instance_methods(false))
  end

  ##############################################################################
  # <<: database
  class Database
    # Class methods are public by default.
    def self.connect; end

    # But can be changed:
    private_class_method(:connect)
  end
  # :>>

  ##############################################################################
  def test_class_methods
    assert_equal([:connect],
                 Database.singleton_class.private_instance_methods(false))
  end
end
