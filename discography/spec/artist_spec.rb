require "spec_helper"

TEST_ALBUMS = [
  Discography::Album.new("The Knife", 2001),
  Discography::Album.new("Deep Cuts", 2003),
  Discography::Album.new("Silent Shout", 2006),
  Discography::Album.new("Shaking the Habitual", 2013),
]

RSpec.describe(Discography::Artist) do
  it "should have a name" do
    artist = Discography::Artist.new("Foo", [])
    expect(artist.name).to eq("Foo")
  end

  it "can find albums by year" do
    artist = Discography::Artist.new("The Knife", TEST_ALBUMS)
    albums = artist.albums(2003)
    expect(albums.size).to eq(1)
    expect(albums.first.year).to eq(2003)
    expect(albums.first).to eq(TEST_ALBUMS[1])
  end

  it "sort_name removes stop words" do
    artist = Discography::Artist.new("The Knife", [])
    expect(artist.sort_name).to eq("Knife")

    artist = Discography::Artist.new("An Unexpected Name", [])
    expect(artist.sort_name).to eq("Unexpected Name")

    artist = Discography::Artist.new("Adam Ant", [])
    expect(artist.sort_name).to eq(artist.name)
  end
end
