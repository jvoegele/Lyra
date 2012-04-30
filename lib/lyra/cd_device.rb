require 'mb-discid'

# Represents a CD device (such as a CD-ROM drive) and provides information
# read from the disc in the device, if any.
class Lyra::CdDevice
  class DiscInfo
    attr_reader :first_track_num, :last_track_num, :sectors, :tracks, :duration
    attr_reader :musicbrainz_disc_id, :freedb_id
    def initialize(mb_disc_id)
      @first_track_num = mb_disc_id.first_track_num
      @last_track_num = mb_disc_id.last_track_num
      @sectors = mb_disc_id.sectors
      @tracks = mb_disc_id.track_details
      @musicbrainz_disc_id = mb_disc_id.id
      @freedb_id = mb_disc_id.freedb_id
      @duration = MusicBrainz::DiscID.sectors_to_seconds(@sectors)
    end
  end

  TrackInfo = MusicBrainz::DiscID::TrackInfo
  class MusicBrainz::DiscID::TrackInfo
    alias_method :duration, :seconds
  end

  def self.default_device
    MusicBrainz::DiscID.default_device
  end

  attr_reader :device

  # Creates a new CdDevice object.
  #
  # If given a single string as its argument, then the argument is interpreted
  # as the path to a device file for the CD device, such as "/dev/cdrom". If not
  # given any arguments, then the default device, as returned by
  # CdDevice.default_device, is used.
  #
  # For the case where a CdDevice object is needed, but access to an underlying
  # device file is not desired or impractical, this method can also accept three
  # arguments that describe the properties of a disc. In this case, the three
  # arguments are interpreted as follows:
  #
  #   first_track_num:: The number of the first track on the disc (Integer)
  #   sectors:: The number of sectors on the disc (Integer)
  #   track_offsets:: The offset of each track on the disc (Array of Integer)
  #
  # Note that the remaining information about the disc can be inferred from the above.
  def initialize(*args)
    case args.size
    when 0
      @device = CdDevice.default_device
    when 1
      @device = args[0]
      @device ||= CdDevice.default_device
    when 3
      @first_track_num = args[0].to_i
      @sectors = args[1].to_i
      @track_offsets = args[2].map {|i| i.to_i}
    else
      raise ArgumentError
    end
  end

  # Returns a CdDevice::DiscInfo object describing the disc in the device,
  # or nil if disc information cannot be obtained (if, for example, there
  # is no disc in the drive).
  def disc_info
    DiscInfo.new(self.mb_disc_id)
  rescue Exception
    nil
  end

protected

  def mb_disc_id
    if @device
      result = MusicBrainz::DiscID.new(@device)
    else
      result = MusicBrainz::DiscID.new
      result.put(@first_track_num, @sectors, @track_offsets)
    end
    result
  end
end
