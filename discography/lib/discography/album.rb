module Discography
  class Album
    include(Discography::Sorting)

    attr_accessor(:name, :year)

    # Convert a Hash into an Album.
    def self.from_hash(hash)
      new(hash["name"], hash["released"].to_i)
    end

    def initialize(name, year)
      @name = name
      @year = year
    end
  end
end
