################################################################################
require('minitest/autorun')

################################################################################
module AllObjects; end

################################################################################
class AllObjects::ModuleTest < MiniTest::Unit::TestCase

  ##############################################################################
  # For Ruby 1.9.3
  class Foo
    if !RUBY_VERSION.match(/^2/)
      def self.prepend (*); end
    end
  end

  ##############################################################################
  # <<: modules
  class Foo
    # Most common way to use a module.
    include(Enumerable) # instance -> instance

    # This works on classes and objects too.
    extend(Enumerable)  # instance -> singleton

    # New in Ruby 2.0, very rare.
    prepend(Enumerable) # instance -> instance
  end
  # :>>

  ##############################################################################
  def test_modules
    assert(Foo)
  end
end
