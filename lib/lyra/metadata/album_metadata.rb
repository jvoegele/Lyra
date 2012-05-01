module Lyra::Metadata

  # Metadata for an album.
  #
  # AlbumMetadata is distinct from its base AudioMetadata class in that it
  # maintains a collection of TrackMetadata.
  class AlbumMetadata < AudioMetadata
    def initialize(hash={})
      super
      @tracks = Array.new
    end

    def tracks
      @tracks.dup.freeze
    end

    def add_track(track)
      track_metadata = case track
      when TrackMetadata
        track.parent_album = self
        track
      when String
        TrackMetadata.new(self, title: track)
      end
      @tracks << track_metadata
      unless track_metadata.tracknumber
        track_metadata.tracknumber = "%02d" % (@tracks.size)
      end
      track_metadata
    end

    alias_method :<<, :add_track
  end
end
