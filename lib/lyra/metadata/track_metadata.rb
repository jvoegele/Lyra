module Lyra::Metadata
  # Metadata for an audio track on an album.  Instances of TrackMetadata are
  # associated with the AlbumMetadata for the containing album.  All metadata
  # for the containing album is inherited by the track, but metadata associated
  # explicitly with the track overrides the inherited album metadata.
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
