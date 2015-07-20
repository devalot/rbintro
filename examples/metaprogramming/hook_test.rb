################################################################################
require('minitest/autorun')

################################################################################
module Metaprogramming; end

################################################################################
class Metaprogramming::HookTest < MiniTest::Unit::TestCase

  ##############################################################################
  # <<: parent
  class Parent
    def self.inherited (klass)
      super # Get into the habit of using super.
      # ...
    end
  end
  # :>>

  ##############################################################################
  def test_parent_hook
    klass = Class.new(Parent)
    assert(klass)
  end

  ##############################################################################
  # <<: included
  module CoolFeatures
    def self.included (klass)
      # ...
    end
  end
  # :>>

  ##############################################################################
  def test_cool_features_hook
    klass = Class.new
    klass.send(:include, CoolFeatures)
    assert(klass)
  end
end
