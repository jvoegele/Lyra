
include Lyra

class Lyra::MetadataDisplay
  def initialize(options={})
    @discid = options[:discid]
    unless @discid
      @cd_device = CdDevice.new(options[:device])
      @disc_info = @cd_device.disc_info
      @discid = @disc_info.musicbrainz_disc_id
    end
  end

  def call
    brainz = Metadata::MusicBrainzMetadataService.new
    puts("Looking up metadata for #{@discid}\n")

    album = brainz.lookup_by_disc_id(@discid)
    album.each do |name, value|
      puts("#{name}: #{value}")
    end

    puts
    puts("Tracks:")
    album.tracks.each do |track|
      num = "%02d" % track.tracknumber.to_i
      puts("#{num} - #{track.title}")
    end
  end
end