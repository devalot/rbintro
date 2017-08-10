################################################################################
require('minitest/autorun')

################################################################################
module ExceptionBasics; end

################################################################################
class ExceptionBasics::ExceptionTest < MiniTest::Test

  ##############################################################################
  module MethodForm

    ############################################################################
    # <<: method
    def parse_file(file_name)
      file = File.open(file_name)
      # Do some work with file
    ensure
      file.close if file
    end
    # :>>

    module_function(:parse_file)
  end

  ##############################################################################
  def test_begin_rescue
    # <<: begin
    begin
      # Something that might raise an exception
    rescue RuntimeError => e
      # Handle or raise again.
    rescue => e
      # Same as catching StandardError and below.
    end
    # :>>

    assert(true)
  end

  ##############################################################################
  def test_ensure
    # <<: ensure
    begin
      # Something that might raise an exception
    ensure
      # Always run.
    end
    # :>>

    assert(true)
  end

  ##############################################################################
  def test_method_form
    f = MethodForm.parse_file('/dev/null')
    assert(f.closed?)
  end

  ##############################################################################
  def test_it_all
    # <<: all
    begin
      # Something that might raise an exception.
    rescue RuntimeError => e
      # Handle or raise again.
    rescue => e
      # Same as catching StandardError and below.
    else
      # Only runs if there are no exceptions.
    ensure
      # Always runs.
    end
    # :>>

    assert(true)
  end
end
