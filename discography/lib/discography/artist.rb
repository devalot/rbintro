module Discography
  class Artist
    attr_accessor(:name)

    # Create a new +Artist+.
    def initialize (name, albums)
      @name   = name
      @albums = albums
    end

    # Return all albums from +year+.
    def albums (year)
      @albums.select do |album|
        album.year == year
      end
    end
  end
end
