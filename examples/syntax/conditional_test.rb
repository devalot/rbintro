################################################################################
require('minitest/autorun')

################################################################################
class ConditionalTest < MiniTest::Unit::TestCase

  ##############################################################################
  def test_only_if
    person = MiniTest::Mock.new
    person.expect(:employed?, true)

    # <<: only-if
    if person.employed?
      # ...
    end
    # :>>

    person.verify
  end

  ##############################################################################
  def test_full_if
    person = MiniTest::Mock.new
    person.expect(:employed?, true)

    # <<: full-if
    if person.employed?
      # ...
    elsif person.age >= 21
      # ...
    else
      # ...
    end
    # :>>

    person.verify
  end

  ##############################################################################
  def test_if_modifier
    person = MiniTest::Mock.new
    person.expect(:age, 20)
    person.expect(:kick, true)

    # <<: if-mod
    person.kick if person.age < 21
    # :>>

    person.verify
  end

  ##############################################################################
  def test_if_assign
    person = MiniTest::Mock.new
    person.expect(:age, 18)

    # <<: if-assign
    status = if person.age >= 18
               'Adult'
             else
               'Minor'
             end
    # :>>

    assert_equal('Adult', status)
    person.verify
  end

  ##############################################################################
  def test_unless
    person = Object.new
    def person.employed?; true; end

    # <<: if-or-unless
    if !person.employed?
      # ...
    end

    unless person.employed?
      # ...
    end
    # :>>
  end
end
