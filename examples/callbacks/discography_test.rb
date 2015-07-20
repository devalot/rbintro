################################################################################
require('minitest/autorun')
require('yaml')

################################################################################
module Callbacks; end

################################################################################
class Callbacks::DiscographyTest < MiniTest::Unit::TestCase

  ##############################################################################
  TEST_FILE = File.expand_path('../data/knife.yml', File.dirname(__FILE__))

  ##############################################################################
  class Album
    attr_accessor(:artist, :name, :year)

    def initialize (artist, name, year)
      self.artist = artist
      self.name   = name
      self.year   = year
    end
  end

  ##############################################################################
  class Discography
    def initialize (albums)
      @albums = albums
    end

    # <<: albums
    def albums (year=nil, &block)
      matches = if year
                  @albums.select {|a| a.year == year}
                else
                  @albums
                end

      matches.each(&block) if block
      matches
    end
    # :>>
  end

  ##############################################################################
  # <<: open
  require("yaml")

  class Discography
    def self.open (file_name)
      albums = YAML.load_file(file_name).map do |album|
        Album.new(album["artist"],
                  album["name"],
                  album["year"])
      end

      new(albums)
    end
  end
  # :>>

  ##############################################################################
  def test_can_open_file
    albums = YAML.load_file(TEST_FILE)
    assert_equal(4, albums.size)
  end

  ##############################################################################
  def test_open_class_method
    discography = Discography.open(TEST_FILE)
    albums = discography.albums(2001)
    assert_equal(1, albums.size)
    assert_equal("The Knife", albums.first.name)
  end
end
