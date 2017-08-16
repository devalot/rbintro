require('yaml')

module Discography
  class Library

    attr_reader(:artists)

    # Returns a Library object that contains all of
    # the artists found in the given file.
    def self.open(file_name)
      data = YAML.load_file(file_name)

      artists = data.map do |raw|
        Discography::Artist.from_hash(raw)
      end

      new(artists)
    end

    def initialize(artists)
      @artists = artists
    end
  end
end
