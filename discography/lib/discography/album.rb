module Discography
  class Album
    attr_accessor(:name, :year)

    def initialize (name, year)
      @name = name
      @year = year
    end
  end
end
