module Lyra::Metadata
  class TrackMetadata < AudioMetadata

    attr_accessor :parent_album

    def initialize(parent_album, hash={})
      unless parent_album.is_a?(AlbumMetadata)
        raise ArgumentError, "album must be an AlbumMetadata object"
      end
      @parent_album = parent_album
      super(hash)
    end

    def has_field?(field_name)
      super(field_name) || @parent_album.has_field?(field_name)
    end

    def [](field_name)
      self.get(field_name) || @parent_album[field_name]
    end
  end
end
