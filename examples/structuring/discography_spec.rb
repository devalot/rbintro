################################################################################
module StructuringSpec

  ##############################################################################
  module Discography

    ############################################################################
    # <<: album
    class Album
      attr_accessor(:name, :year)

      def initialize(name, year)
        self.name = name
        self.year = year
      end
    end
    # :>>

    ############################################################################
    # <<: artist
    class Artist
      attr_accessor(:name)

      def initialize(name, albums)
        self.name = name
        @albums   = albums
      end

      def albums(year)
        @albums.select {|a| a.year == year}
      end
    end
    # :>>
  end

  ##############################################################################
  # <<: constant
  TEST_ALBUMS = [
    Discography::Album.new("The Knife",            2001),
    Discography::Album.new("Deep Cuts",            2003),
    Discography::Album.new("Silent Shout",         2006),
    Discography::Album.new("Shaking the Habitual", 2013),
  ]
  # :>>

  ##############################################################################
  # <<: spec
  describe Discography::Artist do
    context "when calling the albums method" do
      it "should only return appropriate albums" do
        artist = Discography::Artist.new("The Knife",
                                         TEST_ALBUMS)

        albums = artist.albums(2003)
        expect(albums.size).to eq(1)
        expect(albums.first.name).to eq("Deep Cuts")
      end
    end
  end
  # :>>
end
