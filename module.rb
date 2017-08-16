# File A
module A
  def do_setup
    # Code
  end
  module_function(:do_setup)
end

# File B
require('file_a')
A.do_setup
