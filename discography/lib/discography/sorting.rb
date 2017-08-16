module Discography
  module Sorting
    def sort_name
      @name.sub(/^\s*(a|an|the)\s+/i, "")
    end
  end
end
