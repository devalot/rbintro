################################################################################
require('minitest/autorun')
require('yaml')

################################################################################
module Structuring

  ##############################################################################
  module Simple

    ############################################################################
    module Discography

      ##########################################################################
      # <<: album
      class Album
        attr_accessor(:name, :year)

        def initialize(name, year)
          self.name = name
          self.year = year
        end
      end
      # :>>

      ##########################################################################
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

      ##########################################################################
      class Library
        attr_reader(:artists)

        # <<: library-open
        def self.open(file_name)
          data = YAML.load_file(file_name)

          artists = data.map do |raw_artist|
            albums = raw_artist["albums"].map do |raw_album|
              Album.new(raw_album["name"], raw_album["year"])
            end

            Artist.new(raw_artist["name"], albums)
          end

          new(artists)
        end
        # :>>

        def initialize(artists)
          @artists = artists
        end
      end
    end
  end

  ##############################################################################
  class DiscographyTest < MiniTest::Test

    ############################################################################
    include(Simple)

    ############################################################################
    # <<: constant
    TEST_ALBUMS = [
      Discography::Album.new("The Knife",            2001),
      Discography::Album.new("Deep Cuts",            2003),
      Discography::Album.new("Silent Shout",         2006),
      Discography::Album.new("Shaking the Habitual", 2013),
    ]
    # :>>

    ############################################################################
    # <<: test
    def test_artist
      artist = Discography::Artist.new("The Knife",
                                       TEST_ALBUMS)

      albums = artist.albums(2003)
      assert_equal(1, albums.size)
      assert_equal("Deep Cuts", albums.first.name)
    end
    # :>>

    ############################################################################
    def test_library_loading
      file = File.expand_path("../data/artists.yml", File.dirname(__FILE__))
      library = Discography::Library.open(file)
      refute_empty(library.artists)
      assert_kind_of(Array, library.artists)
      library.artists.each do |artist|
        assert_kind_of(Discography::Artist, artist)
        refute_empty(artist.albums(2001))
        artist.albums(2001).each {|a| assert_kind_of(Discography::Album, a)}
      end
    end
  end

  ##############################################################################
  module FromHash

    ############################################################################
    module Discography

      ##########################################################################
      class Album < Structuring::Simple::Discography::Album
        # <<: album-from-hash
        def self.from_hash(raw)
          new(raw["name"], raw["year"])
        end
        # :>>
      end

      ##########################################################################
      class Artist < Structuring::Simple::Discography::Artist
        # <<: artist-from-hash
        def self.from_hash(raw)
          albums = raw["albums"].map {|a| Album.from_hash(a)}
          new(raw["name"], albums)
        end
        # :>>
      end

      ##########################################################################
      class Library < Structuring::Simple::Discography::Library
        # <<: library-open2
        def self.open(file_name)
          data = YAML.load_file(file_name)
          artists = data.map {|raw| Artist.from_hash(raw)}
          new(artists)
        end
        # :>>
      end
    end
  end

  ##############################################################################
  class Discography2Test < MiniTest::Test

    ############################################################################
    include(FromHash)

    ############################################################################
    def test_artist_from_hash
      raw = {
        "name" => "The Knife",
        "albums" => [
          { "name" => "foo",
            "year" => 1999,
          }
        ]
      }

      artist = Discography::Artist.from_hash(raw)
      assert_equal("The Knife", artist.name)
      refute_empty(artist.albums(1999))
    end

    ############################################################################
    def test_library_loading
      file = File.expand_path("../data/artists.yml", File.dirname(__FILE__))
      library = Discography::Library.open(file)
      refute_empty(library.artists)
      assert_kind_of(Array, library.artists)
      library.artists.each do |artist|
        assert_kind_of(Discography::Artist, artist)
        refute_empty(artist.albums(2001))
        artist.albums(2001).each {|a| assert_kind_of(Discography::Album, a)}
      end
    end
  end

  ##############################################################################
  module Sorting

    ############################################################################
    module Discography

      ##########################################################################
      class Artist < Structuring::Simple::Discography::Artist
        # <<: artist-sort-name
        def sort_name
          name.sub(/^(?:The|An?)\s/, '')
        end
        # :>>
      end
    end
  end

  ##############################################################################
  class SortingTest < MiniTest::Test

    ############################################################################
    include(Sorting)

    ############################################################################
    def test_sorting_works
      a1 = Discography::Artist.new("The Knife", [])
      a2 = Discography::Artist.new("An Emergency", [])
      a3 = Discography::Artist.new("A Tribe Called Quest", [])

      assert_equal("Knife", a1.sort_name)
      assert_equal("Emergency", a2.sort_name)
      assert_equal("Tribe Called Quest", a3.sort_name)

      sorted = [a1, a2, a3].sort_by {|a| a.sort_name}
      assert_equal([a2, a1, a3], sorted)
    end
  end
end
