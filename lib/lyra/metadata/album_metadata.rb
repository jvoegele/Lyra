module Lyra::Metadata
  class AlbumMetadata < AudioMetadata
    attr_reader :tracks

    def initialize(hash={})
      super
      @tracks = Array.new
    end

    def add_track(track)
      track_metadata = case track
      when TrackMetadata
        track
      when String
        TrackMetadata.new(title: track)
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
