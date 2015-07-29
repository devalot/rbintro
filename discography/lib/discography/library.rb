require("yaml")

module Discography
  class Library
    attr_reader(:artists)

    def self.open (file_name)
      raw = YAML.load_file(file_name)

      artists = raw.map do |raw_artist|
        albums = raw_artist["albums"].map do |raw_album|
          Discography::Album.new(raw_album["name"],
                                 raw_album["year"])
        end

        Discography::Artist.new(raw_artist["name"], albums)
      end

      new(artists)
    end

    def initialize (artists)
      @artists = artists
    end
  end
end
