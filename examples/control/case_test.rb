################################################################################
require('minitest/autorun')

################################################################################
module Control

  ##############################################################################
  class CaseTest < MiniTest::Test

    ############################################################################
    def do_list_command() :do_list_command; end
    def do_display_artist(x) x; end

    ############################################################################
    def case_command(input)
      # <<: case-input
      case input
      when "list"
        do_list_command
      when /^artist\s(\d+)/
        do_display_artist($1)
      else
        $stdout.puts("Whoa, what does #{input} mean?")
      end
      # :>>
    end

    ############################################################################
    def test_case_command
      assert_equal(:do_list_command, case_command("list"))
      assert_equal("1", case_command("artist 1"))
    end
  end
end
