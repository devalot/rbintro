module Discography
  class Artist
    include(Discography::Sorting)

    attr_accessor(:name, :website)

    # Convert a Hash into an Artist.
    def self.from_hash(hash)
      albums = hash["albums"].map do |raw|
        Discography::Album.from_hash(raw)
      end

      artist = new(hash["name"], albums)
      artist.website = hash["website"]

      artist
    end

    def initialize(name, albums)
      @name    = name
      @albums  = albums
      @website = nil
    end

    # begin
    #   require('byebug')
    #   # You have byebug
    #   raise("here!!")
    # rescue LoadError => e
    #   # You don't have byebug
    #   class Object
    #     def byebug
    #     end
    #   end
    # end

    # Returns an array of albums released
    # on the given year.
    def albums(year=nil)
      return @albums if year.nil?

      Array(@albums).select do |album|
        album.year == year
      end
    end
  end
end
