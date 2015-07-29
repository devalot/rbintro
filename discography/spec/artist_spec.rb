require 'spec_helper'

TEST_ALBUMS = [
  Discography::Album.new("The Knife",    2001),
  Discography::Album.new("Deep Cuts",    2003),
  Discography::Album.new("Silent Shout", 2006),
]

describe Discography::Artist do
  context "The albums method works" do
    it "should return the correct albums" do
      artist = Discography::Artist.new("The Knife", TEST_ALBUMS)
      expect(artist.name).to eq("The Knife")

      # Test that albums returned from the Artist#albums method are
      # what we expect them to be.
      matches = artist.albums(2006)
      expect(matches.length).to eq(1)
      expect(matches.first.year).to eq(2006)
      expect(matches.first.name).to eq("Silent Shout")
    end
  end
end
