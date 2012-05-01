require 'musicbrainz'
require 'locale'

module Lyra::Metadata
  class MusicBrainzMetadataService
    include MusicBrainz

    def lookup_by_disc_id(disc_id)
      brainz = MusicBrainz::Client.new
      query_result = brainz.discid(discid: disc_id,
                                   inc: "artists+artist-credits+labels+recordings+release-groups")
      releases = [query_result.disc.release_list.release].flatten
      release = select_best_release(releases)
      release['mb_disc_id'] = disc_id

      def release.media
        @__release_media ||= [self.medium_list.medium].flatten
      end

      def release.medium
        @__release_medium ||= case self.media.size
        when 1
          self.media.first
        else
          self.media.find { |medium|
            medium.disc_list.disc.any? {|disc| disc.id == self['mb_disc_id']}
          }
        end
      end

      album = create_metadata_from_release(release)
      add_tracks(album, release.medium.track_list.track)
      album
    end

  protected

    def select_best_release(releases)
      region = Locale.candidates.first.region
      releases = releases.sort_by {|r| r.date}
      best_release = releases.find { |r|
        r.country == region
      }
      best_release ||= releases.first
      best_release
    end

    def create_metadata_from_release(release)
      result = AlbumMetadata.new
      artist_credit = release.artist_credit.name_credit
      result.artist = artist_credit.name || artist_credit.artist.name
      result.artistsort = release.artist_credit.name_credit.artist.sort_name
      result.albumartist = result.artist
      result.albumartistsort = result.artistsort
      result.album = release.title
      result.amazon_asin = release.asin
      result.musicbrainz_albumid = release.id
      result.musicbrainz_albumtype= release.release_group.type
      result.musicbrainz_artistid = release.artist_credit.name_credit.artist.id

      result.releasecountry = release.country
      result.date = release.date

      if release.media.size > 1
        medium = release.medium
        if medium
          result.discnumber = medium.position
          result.disctotal = release.media.size
          if subtitle = medium.title
            result.discsubtitle = subtitle
          end
        end
      end

      result
    end

    def add_tracks(album, tracks)
      tracks.each do |t|
        track = TrackMetadata.new(album)
        track.musicbrainz_trackid = t.recording.id
        track.title = t.recording.title
        track.duration = format_duration(t['length'].to_i)

        name_credit = t.recording.artist_credit.name_credit
        track_artist = name_credit.artist
        if track_artist.id != album.musicbrainz_artistid
          track.musicbrainz_artistid = track_artist.id
          track.artist = name_credit.name || track_artist.name
          track.artistsort = track_artist.sort_name
        end
        album << track
      end

    end

    def format_duration(duration)
      t = Time.mktime(0) + (duration / 1000.0).round
      t.strftime("%-M:%S")
    end
  end
end
