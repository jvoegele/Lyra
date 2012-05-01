require 'rbrainz'
require 'locale'

module Lyra::Metadata
  class MusicBrainzMetadataService
    include MusicBrainz

    def query(criteria)
      mb_query = Webservice::Query.new

      if disc_id = criteria[:disc_id]
        releases = mb_query.get_releases(discid: disc_id, cdstubs: true)
        release = select_best_release(releases)
        album = create_metadata_from_release(release)
        add_tracks(album, release.tracks)
      end

      album
    end

  protected

    RELEASE_INCLUDES = {
      :artist => true,
      :counts => true,
      :release_groups => true,
      :release_events => true,
      :discs => true,
      :tracks => true,
      :labels => true,
      :isrcs => true,
      :url_rels => true,
      :tags => true
    }

    TRACK_INCLUDES = {
      artist: true,
      duration: true
    }

    def select_best_release(releases)
      region = Locale.candidates.first.region
      best_release = releases.find { |r|
        release_event = r.entity.release_events.first
        release_event.country == region
      }
      best_release ||= releases.min_by { |r|
        release_event = r.entity.release_events.first
        release_event.date
      }
      best_release.entity
    end
require 'pry'
    def create_metadata_from_release(release)
      result = AlbumMetadata.new
      result.artist = release.artist.name
      result.artistsort = release.artist.sort_name
      result.albumartist = release.artist.name
      result.albumartistsort = release.artist.sort_name
      result.album = release.title
      result.amazon_asin = release.asin
      result.musicbrainz_albumid = release.id
      result.musicbrainz_albumtype= MusicBrainz::Utils.remove_namespace(release.types.first)
      result.musicbrainz_artistid = release.artist.id
      unless release.single_artist_release?
        result.compilation = true
      end

      release_event = release.release_events.first
      result.releasecountry = release_event.country
      result.date = release_event.date.to_s

      result
    end

    def add_tracks(album, tracks)
      tracks.each do |t|
        track = TrackMetadata.new(album)
        track.MUSICBRAINZ_TRACKID = t.id
        track.title = t.title
        track.duration = format_duration(t.duration)
        track.MUSICBRAINZ_ARTISTID = t.artist.id
        track.artist = t.artist.name
        track.artistsort = t.artist.sort_name
        album << track
      end
    end

    def format_duration(duration)
      t = Time.mktime(0) + (duration / 1000.0).round
      t.strftime("%-M:%S")
    end
  end
end
