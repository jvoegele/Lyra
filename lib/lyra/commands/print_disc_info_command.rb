require 'terminal-table'

include Lyra

class Lyra::PrintDiscInfoCommand
  include TimeHelper

  attr_reader :device, :verbose

  def initialize(device=nil, options={})
    @device = CdDevice.new(device)
    @verbose = options[:verbose]
  end

  def execute
    puts("Reading disc information from #{@device.device}")
    puts

    disc_info = @device.disc_info
    unless disc_info
      raise "Could not read #{@device.device}. Is there a disc in the drive?"
    end

    puts("First track: #{disc_info.first_track_num}")
    puts("Last track: #{disc_info.last_track_num}")
    puts("Sectors: #{disc_info.sectors}")
    puts("Total length: #{disc_info.duration}")
    puts("MusicBrainz DiscID: #{disc_info.musicbrainz_disc_id}")
    puts("FreeDB ID: #{disc_info.freedb_id}")

    puts("Tracks:")
    if verbose
      headings = ['No.', 'Length', 'Start Time', 'End Time', 'Total Sectors', 'Start Sector', 'End Sector']
      table = Terminal::Table.new(headings: headings)
      disc_info.tracks.each do |track|
        row = [format_duration(track.duration),
               track.number,
               format_duration(track.start_time),
               format_duration(track.end_time),
               track.sectors,
               track.start_sector,
               track.end_sector]
        table << row
      end
      puts(table.to_s)
    else
      disc_info.tracks.each do |track|
        printf("\t%02d. %s (%i sectors)\n", track.number, format_duration(track.duration), track.sectors)
      end
    end
  end
end